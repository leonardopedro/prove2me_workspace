-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.qgFixing_gaugeField_ne_zero_of_not_fixed
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

theorem BookProof.QgDerivativeRealization.qgFixing_gaugeField_ne_zero_of_not_fixed (mu : Fin 4) (f w : SpacetimePoly)
    (h : w ≠ pderiv mu f) :
    gaugeField (qgFixingSystem mu f w).toGaugeFixingSystem ≠ 0 := by sorry
