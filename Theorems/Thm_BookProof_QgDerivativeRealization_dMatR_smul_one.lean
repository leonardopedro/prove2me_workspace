-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.dMatR_smul_one
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization



open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

theorem BookProof.QgDerivativeRealization.dMatR_smul_one (mu : Fin 4) (f : SpacetimePoly) :
    dMatR mu (f • (1 : Mat2R)) = (pderiv mu f) • (1 : Mat2R) := by sorry
