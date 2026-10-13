-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.le_amp
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (P : PairShift ι)

set_option maxHeartbeats 1000000 in

theorem solution {κ : ℝ} (hκ : 0 ≤ κ) (n : ℕ) : (κ / 2) * ((n : ℝ) + 1) ≤ amp κ n := by
  have hnn : (0 : ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
  have hle : ((n : ℝ) + 1) ≤ Real.sqrt (((n : ℝ) + 1) * ((n : ℝ) + 2)) := by
    have h := Real.sqrt_le_sqrt (show ((n : ℝ) + 1) ^ 2 ≤ ((n : ℝ) + 1) * ((n : ℝ) + 2) by
      nlinarith)
    rwa [Real.sqrt_sq (by linarith)] at h
  unfold amp
  exact mul_le_mul_of_nonneg_left hle (by positivity)
