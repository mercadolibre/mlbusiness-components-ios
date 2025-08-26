## [Unrelease]

- Andes update in MLBusinessComponents.podspec

## [1.59.0]
- Modificado el componente MLBusinessAnimatedButton para que use colores de Andes.
- Se actualizaron los componentes de CrossSelling y DownloadApp para usar los colores de AndesUI.

## [1.58.0]
### Fixed
- Se verifica una URL sacando la vulnerabilidade de injeción de HTML (XSS) y arreglamos el bug que no aparecia la imagen

## [1.57.0] - 2024-04-17
### Fixed
- Se verifica una URL sacando la vulnerabilidade de injeción de HTML (XSS)

## [1.56.2] - 2023-07-10
### Fixed
- Se revierten cambios de LoyaltyCongrats para agilizar otros desarrollos

## [1.56.1] - 2023-07-10
### Fixed
- Modificada firma de LoyaltyHeader para que sea retrocompatible

## [1.56.0] - 2023-07-07
## Changed
- Modificado componente de congrats de Loyalty, permitiendo agregar una imagen y mostrar o no el diferentes partes existentes
- Se agregan las modificaciones necesarias en el componente de Beneficios de Loyalty para poder mandar la data del progress ring en null y seguir pintando correctamente el componente.

## [1.55.0] - 2023-05-18
## Added
- Se agrega params para soportar logo de store y ranking en Dynamic Carrousel.

## [1.54.0] - 2023-02-01
## Added
- (LiveImages) Se agrega validacion para no mostrar imagenes animadas segun estado de bateria y consumo datos.
- (LiveImages) Se agregan estados adicionales del componente de imagenes animadas.

## [1.53.0] - 2023-01-26
## Changed
- (LiveImages) Se cambia parte de la arquitectura para que sea consistente en mobile.

## [1.52.0] - 2023-01-18
## Added
- Manejo de cache para LiveImages

## [1.51.0] - 2023-01-11
### Fixed
- Issue en LiveImages que hacia que se vean de manera incorrecta algunas animaciones.

## [1.50.0] - 2022-12-28
### Added
- LiveImages cuenta con play/pause de las animacion segun estado de foco del carousel.
- Se implementa accesibilidad a FlexCoverCarousel

## [1.49.2] - 2022-12-27
### Fixed
- Default value multimediaCover en DynamicCoverCarousel.

## [1.49.1] - 2022-12-26
### Added
- Se agrega soporte para imagenes animadas en DynamicCoverCarousel.

## [1.49.0] - 2022-12-7
### Modified
- FlexCoverCarousel - Se unifica el color del gradiente con respecto del sólido que lo continúa.
- FlexCoverCarousel - Se soporta que la card solo tenga imagen 

## [1.48.0] - 2022-11-30
### Modified
- Se realizan ajustes de accesibilidad en la MultipleDescriptionView para que la moneda sea interpretada como "peso" o "real" por el VoiceOver y no como "dolar".

## [1.47.0] - 2022-11-25
### Added
- Add "Dynamic cover carousel" component
- Add func to apply alpha in DynamicCoverCarouselItem.

## [1.46.0] - 2022-11-09
### Changed
- Updated FlexCoverCarousel padding values.

## [1.45.0] - 2022-10-26
### Added
- Title position dynamic on FlexCoverCarousel

### Modified
- Gradient height changes on FlexCoverCarousel
- Paddings changes

# v1.44.0
🚀 1.44.0 🚀
### Fixed
- Fix issue in tracking print for component FlexCoverCarousel

# v1.43.1
🚀 1.43.1 🚀
- Changed MLBusinessItemDescriptionView title number of lines to 3
- Fix FlexCoverCarousel cards when receiving nil in text parameters.
- Fix for cases when we don't have the labels' color values from be

# v1.42.0
🚀 1.42.0 🚀
- Fix in how FlexCoverCarousel Cells were reusing data.
- Added Skeleton View for Touchpoint FlexCoverCarousel.

# v1.41.0
🚀 1.41.0 🚀
- Added support for multiple logos in Touchpoint FlexCoverCarousel.
- Fix behaviour when tapping on partially visible cards in Touchpoint.

# v1.40.0
🚀 1.40.0 🚀
- Fix FlexCoverCarousel support ui parameters from backend.

# v1.39.0
🚀 1.39.0 🚀
- Added FlexCoverCarousel component in Touchpoint.

# v1.38.0
🚀 1.38.0 🚀
- Fix size of text in Touchpoints full card type

# v1.37.0
🚀 1.37.0 🚀
- Fix card spaces in touchpoints full card type

# v1.36.0
🚀 1.36.0 🚀
- Adding a full type in Touchpoints carousel

# v1.35.0
🚀 1.35.0 🚀
- Fix accessibility in carousel touchpoints

# v1.34.1
🚀 1.34.1 🚀
- Allow optional icon color usage on benefits items

# v1.34.0
🚀 1.34.0 🚀
- Add size to MLBusinessMultipleDescriptionView text and images

# v1.33.1
🚀 1.33.1 🚀
- Removed default initializer for optional icon color support on item description data

# v1.33.0
🚀 1.33.0 🚀
- Added optional icon color support on item description data

# v1.32.0
🚀 1.32.0 🚀
- Added `main_label_top` attribute on Hybrid Row

# v1.31.0
🚀 1.31.0 🚀
- Fix en `setAdditionalEdgeInsets(with:)` para el Cover Carousel
- Added closed status support to title and subtile on Hybrid Row

# v1.30.0
🚀 1.30.0 🚀
- Static frameworks

# v1.29.0
🚀 1.29.0 🚀
- Added closed status support to Row
- Added Status Description to Row
- Added closed status support to Hybrid Carousel

# v1.28.0
🚀 1.28.0 🚀
- Signature refactor in Cover Carousel

# v1.27.0
🚀 1.27.0 🚀
- Added Cover Carousel Component

# v1.26.0
🚀 1.26.0 🚀
- Added dynamic width for description on Row Component
- Fix center icon on Touchpoint Grid

# v1.25.0
🚀 1.25.0 🚀
- Fix for Xcode 12 and iOS 14 API
- Fix for conflicts between MLBusinessComponent.PressableView and HomeSectionAPI.PressableView

# v1.24.0
🚀 1.24.0 🚀
- Fixes in Hybrid Carousel Component

# v1.23.0
🚀 1.23.0 🚀
- Improvements in Sheet

# v1.22.0
🚀 1.22.0 🚀
- Updated Row Component

# v1.21.0
🚀 1.21.0 🚀
- Loyalty Broadcast

# v1.20.0
🚀 1.20.0 🚀
- New Sheet Component

# v1.19.0
🚀 1.19.0 🚀
- Added Multiple Row Component
- Resized pill icon on Hybrid Carousel
- Added Multiple Description Component
- Added Multiple Description to Row
- New image accesory for Hyrbrid Carousel Card

# v1.18.0
🚀 1.18.0 🚀
- Added Hybrid Carousel Component

# v1.17.0
🚀 1.17.0 🚀
- Fix MLBusinessActionCardView shadow
- Added Row Component

# v1.16.0
🚀 1.16.0 🚀
- Changed Dividing Line View stroke color (darker)
- Make MLBusinessTouchpointView Carousel public

# v1.15.0
🚀 1.15.0 🚀
- Reduce image sizes

# v1.14.0
🚀 1.14.0 🚀
- New dynamic carousel card width in MLBusinessTouchpointView.
- MLBusinessActionCardView added

# v1.13.0
🚀 1.13.0 🚀
- Added optionals subtitle and button support to MLBusinessLoyaltyRingView.
- Fixed tracker on MLBusinessTouchpointView

# v1.12.0
🚀 1.12.0 🚀
- Added getTouchpointViewHeight for Discount Touchpoints Component.

# v1.11.0
🚀 1.11.0 🚀
- Added categories card to carousel

# v1.10.0
🚀 1.10.0 🚀
- Added setCanOpenMercadoPagoApp for Discount Touchpoints Component.

# v1.9.1
🚀 1.9.1 🚀
- Updated print logic for Discount Touchpoints Component.

# v1.9.0
🚀 1.9.0 🚀
- Discount Touchpoints Component added.

# v1.8.4
🚀 1.8.4 🚀
- Fixing Animated button resetLoading function.

# v1.8.3
🚀 1.8.3 🚀
- Ajustes en label de DiscountBox
- Ajustes en labels de Loyaty Ring View

# v1.8.2
🚀 1.8.2 🚀
- Animated button shouldPop param.
- Animated button resetLoading function.

# v1.8.1
🚀 1.8.1 🚀
- Restored tap tracking on Discount Box component.
- Modified MLBusinessDiscountTrackerProtocol.

# v1.8
🚀 1.8 🚀
- Added discount tracker and tracking functionality.
- Discount Box component refactor.

# v1.7
🚀 1.7 🚀
- Change background color and changes in tappable area.

# v1.6
🚀 1.6 🚀
- Overlay discount single item

# v1.5.1
🚀 1.5.1 🚀
- Animated Button disabled state

# v1.5
🚀 1.5 🚀
- Animated Button Component with Transition.

# v1.4.1
- Modified font size of discount box.

# v1.4
🚀 1.4 🚀
- Modified iconCornerRadius on MLBusinessDiscountSingleItemView to 28 in order to make circle icons. Changed icon contentMode to scaleAspectFill.
- Adjust the size of the Ring view.

# v1.3
🚀 1.3 🚀
- Discount Box component 3 layout. (With title and subtitle, with title and without title/subtitle)

# v1.2
🚀 1.2 🚀
- Change the font size of header's labels.

# v1.1
🚀 1.1 🚀
- DownloadView improvements for small devices.

# v1.0.9
🚀 1.0.9 🚀
- Change target version to iOS 10	- DownloadView improvements for small devices.
- Fix an issue in MLBusinessDiscountBoxView in iOS 10
- L&F fixes

# v1.0.8
🚀 1.0.8 🚀
- DiscountBox Items with Default 6px corner radius.
- Crosseling box improvements.

# v1.0.7
🚀 1.0.7 🚀
- Support full Objc
- Change setBackgroundColor by setCustomBackgroundColor

# v1.0.6
🚀 1.0.6 🚀
- Image cache improvements.

# v1.0.5
🚀 1.0.5 🚀
- Se agrega el componente MLBusinessItemDescriptionView
- Posibilidad de setear backgroundColor a DownloadAppView
- Posibilidad de setear cornerRadius a DownloadAppView

# v1.0.4
🚀 1.0.4 🚀
- Se agrega el componente MLBusinessLoyaltyHeaderView

# v1.0.3
🚀 1.0.3 🚀
- CrossSellingBoxView Component
- Fix bug LoyaltyRingView

# v1.0.2
🚀 1.0.2 🚀
- Download Component
- Dividing Line component
- Item distribution improvements for discount box
- Update feature for discount box

# v1.0.1
🚀Improvements Sign of MLBusinessDiscountBoxData 🚀
- Improvements for MLBusinessDiscountBoxData sign (title and subtitle are optionals)

# v1.0
🚀First Release 1.0 🚀
- DiscountBoxView
- LoyaltyRingView
- Dividing triangle line
