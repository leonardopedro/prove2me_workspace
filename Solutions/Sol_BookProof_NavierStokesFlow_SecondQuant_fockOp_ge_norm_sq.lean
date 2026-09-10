-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockOp_ge_norm_sq
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant









open scoped ENNReal



open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}
private theorem rpow_two_eq (x : ℝ) : x ^ ((2 : ℝ≥0∞).toReal) = x ^ 2 := by
  have h : ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) := by norm_num
  rw [h, Real.rpow_natCast]

set_option maxHeartbeats 1000000 in
theorem solution (N : ∀ m, D m →ₗ[ℂ] D m)
    (hb : ∀ (m : ι) (x : D m),
      ‖(x : S m)‖ ^ 2 ≤ (inner ℂ ((x : S m)) ((N m x : D m) : S m) : ℂ).re)
    (v : fockCore D) :
    ‖(v : lp S 2)‖ ^ 2
      ≤ (inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re := by

  have hp : (0 : ℝ) < (2 : ℝ≥0∞).toReal := by norm_num
  have hnorm := lp.hasSum_norm hp ((v : lp S 2))
  have hN := lp.hasSum_inner (𝕜 := ℂ) ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2)
  have hNre : HasSum
      (fun m => (inner ℂ ((v : lp S 2) m) (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re)
      ((inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re) :=
    hN.map Complex.reAddGroupHom Complex.continuous_re
  have hterm : ∀ m : ι, ‖((v : lp S 2) m)‖ ^ ((2 : ℝ≥0∞).toReal)
      ≤ (inner ℂ ((v : lp S 2) m)
          (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re := by
    intro m
    rw [rpow_two_eq]
    exact hb m ⟨(v : lp S 2) m, (v.2).2 m⟩
  have hsum := hasSum_le hterm hnorm hNre
  rwa [rpow_two_eq] at hsum
