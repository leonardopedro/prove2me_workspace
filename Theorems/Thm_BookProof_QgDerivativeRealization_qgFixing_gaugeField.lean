-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.qgFixing_gaugeField
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing
open BookProof.QgDerivativeRealization



open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

theorem BookProof.QgDerivativeRealization.qgFixing_gaugeField (mu : Fin 4) (f w : SpacetimePoly) :
    gaugeField (qgFixingSystem mu f w).toGaugeFixingSystem
      = (w - pderiv mu f) • (1 : Mat2R) := by sorry
