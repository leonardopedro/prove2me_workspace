-- Generated from ChapterNavierStokesFockFarisLavine.lean — solution of BookProof.NavierStokesFlow.SecondQuant.fockOp_norm_inner_le_of_sectors
import Mathlib
import Definitions.Def_ChapterNavierStokesFockFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SecondQuant









open scoped ENNReal



open FarisLavineLift

variable {ι : Type*}
variable {S : ι → Type*} [∀ m, NormedAddCommGroup (S m)] [∀ m, InnerProductSpace ℂ (S m)]
variable {D : ∀ m, Submodule ℂ (S m)}

set_option maxHeartbeats 1000000 in
theorem solution (A N : ∀ m, D m →ₗ[ℂ] D m) (c₂ : ℝ)
    (hb : ∀ (m : ι) (x : D m), ‖(inner ℂ ((x : S m)) ((A m x : D m) : S m) : ℂ)‖
      ≤ c₂ * (inner ℂ ((x : S m)) ((N m x : D m) : S m) : ℂ).re)
    (v : fockCore D) :
    ‖(inner ℂ ((v : lp S 2)) ((fockOp A v : fockCore D) : lp S 2) : ℂ)‖
      ≤ c₂ * (inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re := by

  have hA := lp.hasSum_inner (𝕜 := ℂ) ((v : lp S 2)) ((fockOp A v : fockCore D) : lp S 2)
  have hN := lp.hasSum_inner (𝕜 := ℂ) ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2)
  have hNre : HasSum
      (fun m => (inner ℂ ((v : lp S 2) m) (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re)
      ((inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re) :=
    hN.map Complex.reAddGroupHom Complex.continuous_re
  have hterm : ∀ m : ι,
      ‖(inner ℂ ((v : lp S 2) m) (((fockOp A v : fockCore D) : lp S 2) m) : ℂ)‖
        ≤ c₂ * (inner ℂ ((v : lp S 2) m)
            (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re := by
    intro m
    exact hb m ⟨(v : lp S 2) m, (v.2).2 m⟩
  have hmaj := hNre.mul_left c₂
  have hsummable_norm : Summable fun m : ι =>
      ‖(inner ℂ ((v : lp S 2) m) (((fockOp A v : fockCore D) : lp S 2) m) : ℂ)‖ :=
    Summable.of_nonneg_of_le (fun m => norm_nonneg _) hterm hmaj.summable
  calc ‖(inner ℂ ((v : lp S 2)) ((fockOp A v : fockCore D) : lp S 2) : ℂ)‖
      = ‖∑' m : ι, (inner ℂ ((v : lp S 2) m)
          (((fockOp A v : fockCore D) : lp S 2) m) : ℂ)‖ := by rw [hA.tsum_eq]
    _ ≤ ∑' m : ι, ‖(inner ℂ ((v : lp S 2) m)
          (((fockOp A v : fockCore D) : lp S 2) m) : ℂ)‖ :=
        norm_tsum_le_tsum_norm hsummable_norm
    _ ≤ ∑' m : ι, c₂ * (inner ℂ ((v : lp S 2) m)
          (((fockOp N v : fockCore D) : lp S 2) m) : ℂ).re :=
        Summable.tsum_mono hsummable_norm hmaj.summable hterm
    _ = c₂ * (inner ℂ ((v : lp S 2)) ((fockOp N v : fockCore D) : lp S 2) : ℂ).re :=
        hmaj.tsum_eq
