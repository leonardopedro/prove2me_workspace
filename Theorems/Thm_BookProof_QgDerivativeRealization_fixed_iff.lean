-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.fixed_iff
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

theorem BookProof.QgDerivativeRealization.fixed_iff (T : TetradConfig) (E : DerivFields) :
    Fixed T E ↔ ∀ mu nu a, E mu nu a = pderiv mu (T.comp nu a) := by sorry
