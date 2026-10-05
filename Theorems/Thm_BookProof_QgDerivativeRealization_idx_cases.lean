-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.idx_cases
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge
open BookProof.QgDerivativeRealization



open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

theorem BookProof.QgDerivativeRealization.idx_cases (j : Fin 84) :
    (∃ mu, j = idxX mu) ∨ (∃ mu a, j = idxE mu a) ∨ (∃ mu nu a, j = idxDE mu nu a) := by sorry
