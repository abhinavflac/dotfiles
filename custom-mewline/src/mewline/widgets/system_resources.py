import subprocess
from threading import Lock

import psutil
from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.revealer import Revealer
from fabric.utils import exec_shell_command_async
from gi.repository import GLib
from loguru import logger

from mewline.shared.widget_container import ButtonWidget


class ResourcesWidget(ButtonWidget):
    def __init__(self, **kwargs):
        super().__init__(name="system-resources", **kwargs)
        self._lock = Lock()
        self.gpu_model = "NVIDIA GPU"

        # 1. Summary Section (RAM Digits - Always visible)
        self.summary_icon = Label(label="", style_classes="panel-text-icon", style="font-weight: bold; margin-right: 4px;")
        self.summary_label = Label(label="0.0", style="font-weight: bold;")

        # 2. Detailed Section (RAM Suffix, CPU & GPU)
        self.ram_suffix = Label(label="GB", style="font-weight: bold; margin-left: 4px; margin-right: 8px;")
        
        self.cpu_icon = Label(label="", style_classes="panel-text-icon", style="font-weight: bold; margin-right: 4px;")
        self.cpu_label = Label(label="0%", style="font-weight: bold; margin-right: 8px;")
        
        self.gpu_icon = Label(label="󰢮", style_classes="panel-text-icon", style="font-weight: bold; margin-right: 4px;")
        self.gpu_label = Label(label="0%", style="font-weight: bold; margin-right: 4px;")

        self.details_box = Box(spacing=0, orientation="h")
        self.details_box.children = [
            self.ram_suffix,
            self.cpu_icon, self.cpu_label,
            self.gpu_icon, self.gpu_label
        ]

        self.revealer = Revealer(
            transition_type="slide-right",
            transition_duration=400,
            child=self.details_box
        )

        # Main Layout
        self.main_container = Box(spacing=0, orientation="h")
        self.main_container.children = [
            self.summary_icon, self.summary_label,
            self.revealer
        ]
        self.add(self.main_container)

        # Event Handlers
        self.connect("enter-notify-event", self._on_hover_enter)
        self.connect("leave-notify-event", self._on_hover_leave)
        self.connect("clicked", lambda *_: exec_shell_command_async("kitty -e btop"))

        # Initialization
        self._get_gpu_model()
        self.update_stats()
        GLib.timeout_add_seconds(2, self.update_stats)

    def _on_hover_enter(self, *args):
        self.revealer.set_reveal_child(True)
        return False

    def _on_hover_leave(self, *args):
        self.revealer.set_reveal_child(False)
        return False

    def _get_gpu_model(self):
        try:
            res = subprocess.run(
                ["nvidia-smi", "--query-gpu=name", "--format=csv,noheader"],
                capture_output=True, text=True
            )
            if res.returncode == 0:
                self.gpu_model = res.stdout.strip()
        except Exception:
            pass

    def update_stats(self) -> bool:
        if self._lock.locked():
            return False
            
        with self._lock:
            GLib.Thread.new(None, self._update_stats_thread)
        return True

    def _update_stats_thread(self):
        try:
            # CPU
            cpu_percent = psutil.cpu_percent()
            # RAM
            ram = psutil.virtual_memory()
            ram_used_gb = ram.used / (1024**3)
            # GPU
            gpu_percent = 0
            try:
                gpu_result = subprocess.run(
                    ["nvidia-smi", "--query-gpu=utilization.gpu", "--format=csv,noheader,nounits"],
                    capture_output=True, text=True, timeout=1
                )
                if gpu_result.returncode == 0:
                    gpu_percent = int(gpu_result.stdout.strip())
            except Exception:
                gpu_percent = 0

            GLib.idle_add(self._apply_stats, cpu_percent, ram_used_gb, ram.total / (1024**3), gpu_percent)
        except Exception as e:
            logger.error(f"[Resources] Background check failed: {e}")

    def _apply_stats(self, cpu, ram_used, ram_total, gpu):
        try:
            # Update labels
            self.summary_label.set_label(f"{ram_used:.1f}")
            self.cpu_label.set_label(f"{int(cpu)}%")
            self.gpu_label.set_label(f"{int(gpu)}%")
            
            # Detailed Tooltip
            tooltip = (
                f"  Memory: {ram_used:.1f}GB / {ram_total:.1f}GB\n"
                f"  CPU Usage: {int(cpu)}%\n"
                f"󰢮  GPU: {self.gpu_model} ({int(gpu)}%)"
            )
            self.set_tooltip_text(tooltip)
        except Exception:
            pass
