# Copyright (C) 2019 LLuviaOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# LLuviaOS versioning
LLUVIA_VERSION = 5.0

LLUVIA_MOD_VERSION := LLuviaOS-$(LLUVIA_VERSION)-$(shell date -u +%Y%m%d-%H%M)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.lluvia.version=$(LLUVIA_VERSION) \
  ro.modversion=$(LLUVIA_MOD_VERSION)

LLUVIA_DISPLAY_VERSION := $(LLUVIA_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.lluvia.display.version=$(LLUVIA_DISPLAY_VERSION)
