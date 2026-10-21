-- Generated from ChapterQgPhysicalSectorIdentity.lean — solution of BookProof.QgPhysicalSectorIdentity.coupling_weighted_summable
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Theorems.Thm_BookProof_QgPhysicalSectorIdentity_wsum_creIdx
import Theorems.Thm_BookProof_QgPhysicalSectorIdentity_wsum_annIdx
open BookProof.QgPhysicalSectorIdentity




open BookProof.GaugeFixing
open BookProof.FockQuadratic
open BookProof.OperatorSeries
open BookProof.FarisLavine
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal

variable {F : BiDegree → Type} (S : DerivativeVariableFixingSystem F)
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {ω : ι → ℝ} (h : ι × ι → ℂ)
    (hsum : Summable fun k : ι × ι => ‖h k‖ * (ω k.1 + ω k.2 + 2)) :
    Summable fun k : ι × ι => ‖h k‖ * (wsum ω (creIdx k.1) + wsum ω (annIdx k.2) + 2) := by

  refine hsum.congr ?_
  intro k
  rw [wsum_creIdx, wsum_annIdx]
