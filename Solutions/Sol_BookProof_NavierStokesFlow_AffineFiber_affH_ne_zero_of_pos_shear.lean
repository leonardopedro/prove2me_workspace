-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.affH_ne_zero_of_pos_shear
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_affH_coord_succ
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable (P : PairShift ι)

set_option maxHeartbeats 1000000 in
theorem solution {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 < c) :
    affH hκ hc.le (basisState κ c 0) ≠ 0 :=
  ift is not an artefact of the bookkeeping. -/
  theorem affH_ne_zero_of_pos_shear {κ c : ℝ} (hκ : 0 ≤ κ) (hc : 0 < c) :
      affH hκ hc.le (basisState κ c 0) ≠ 0 := by
    intro h0
    have hcoord := affH_coord_succ hκ hc.le 0
    rw [h0] at hcoord
    simp only [lp.coeFn_zero, Pi.zero_apply] at hcoord
    have hshear : shear c 0 ≠ 0 := by
      have h2 : (0 : ℝ) < Real.sqrt 2 := by rw [Real.sqrt_pos]; norm_num
      have h1 : (0 : ℝ) < Real.sqrt (((0 : ℕ) : ℝ) + 1) := by rw [Real.sqrt_pos]; norm_num
      unfold
