import datetime

from fabric.utils import exec_shell_command_async
from fabric.widgets.box import Box
from fabric.widgets.label import Label
from fabric.widgets.revealer import Revealer
from gi.repository import GLib

import mewline.constants as cnst
from mewline.config import cfg
from mewline.shared.widget_container import ButtonWidget


class DateTimeWidget(ButtonWidget):
    def __init__(self, **kwargs):
        super().__init__(name="date-time-button", **kwargs)
        self.config = cfg.modules.datetime
        self.show_date = False

        self.date_label = Label(name="date-label", style="margin-right: 6px;")
        self.time_label = Label(name="time-label")
        
        self.revealer = Revealer(
            transition_type="slide-right",
            transition_duration=400,
            child=self.date_label
        )
        
        self.children = Box(
            spacing=0,
            v_align="center",
            orientation="h",
            children=(self.revealer, self.time_label),
        )

        self.update_labels()
        GLib.timeout_add_seconds(1, self.update_labels)

        self.connect("button-press-event", self._on_button_press)

    def update_labels(self) -> bool:
        now = datetime.datetime.now()
        self.date_label.set_label(now.strftime("%d-%m-%y"))
        self.time_label.set_label(now.strftime("%H:%M"))
        return True

    def _on_button_press(self, widget, event):
        if event.button == 1:
            self.show_date = not self.show_date
            self.revealer.set_reveal_child(self.show_date)
        elif event.button == 3:
            exec_shell_command_async(
                cnst.kb_di_open.format(module="date_notification")
            )
        return True
