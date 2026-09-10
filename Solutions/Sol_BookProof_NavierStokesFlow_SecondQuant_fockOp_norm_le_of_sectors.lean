-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockOp_norm_le_of_sectors
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
theorem solution (H N : ∀ m, D m →ₗ[ℂ] D m) (cst : ℝ) (hc : 0 ≤ cst)
    (hb : ∀ (m : ι) (x : D m), ‖((H m x : D m) : S m)‖ ≤ cst * ‖((N m x : D m) : S m)‖)
    (v : fockCore D) :
    ‖((fockOp H v : fockCore D) : lp S 2)‖ ≤ cst * ‖((fockOp N v : fockCore D) : lp S 2)‖ := by

  have hp : (0 : ℝ) < (2 : ℝ≥0∞).toReal := by norm_num
  have h1 := lp.hasSum_norm hp ((fockOp H v : fockCore D) : lp S 2)
  have h2 := (lp.hasSum_norm hp ((fockOp N v : fockCore D) : lp S 2)).mul_left (cst ^ 2)
  have hterm : ∀ m : ι,
      ‖(((fockOp H v : fockCore D) : lp S 2) m)‖ ^ ((2 : ℝ≥0∞).toReal)
        ≤ cst ^ 2 * ‖(((fockOp N v : fockCore D) : lp S 2) m)‖ ^ ((2 : ℝ≥0∞).toReal) := by
    intro m
    rw [rpow_two_eq _, rpow_two_eq _]
    have hbm := hb m ⟨(v : lp S 2) m, (v.2).2 m⟩
    have hHm : (((fockOp H v : fockCore D) : lp S 2) m)
        = ((H m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m) := rfl
    have hNm : (((fockOp N v : fockCore D) : lp S 2) m)
        = ((N m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m) := rfl
    rw [hHm, hNm]
    nlinarith [norm_nonneg ((H m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m),
      norm_nonneg ((N m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m), hbm,
      mul_nonneg hc (norm_nonneg ((N m ⟨(v : lp S 2) m, (v.2).2 m⟩ : D m) : S m))]
  have hsum := hasSum_le hterm h1 h2
  rw [rpow_two_eq _, rpow_two_eq _] at hsum
  nlinarith [norm_nonneg ((fockOp H v : fockCore D) : lp S 2),
    norm_nonneg ((fockOp N v : fockCore D) : lp S 2),
    mul_nonneg hc (norm_nonneg ((fockOp N v : fockCore D) : lp S 2))]
