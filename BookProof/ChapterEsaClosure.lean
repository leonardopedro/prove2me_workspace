import Mathlib
import BookProof.ChapterNavierStokesEsa
import BookProof.ChapterHashimotoComplexShifts
import BookProof.ChapterEsaClosureCore

/-!
# The closure of an essentially self-adjoint operator: the Hashimoto/SIRK consequence

The abstract theory — the graph `opGraph`, its closure `clGraph`, the closed
extension `clExt`, the self-adjointness criterion and the Cayley transform —
lives in `BookProof.ChapterEsaClosureCore`, which depends only on
`BookProof.ChapterFarisLavineCore` and Mathlib.  This module adds the part that
talks to the Hashimoto/SIRK shift-invert algorithm of
`BookProof.ChapterHashimotoComplexShifts`.
-/

open Filter Topology

namespace BookProof.EsaClosure

open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

/-! ## The positive companion of `IsSelfAdjointExtension` -/

/-- A *positive* self-adjoint extension is in particular a self-adjoint extension. -/
theorem isSelfAdjointExtension_of_positive {D Dom : Submodule ℂ F} {H : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (h : IsPositiveSelfAdjointExtension H A) : IsSelfAdjointExtension H A :=
  ⟨h.1, h.2.1, h.2.2.2⟩

section Positive

variable [CompleteSpace F]

/-- **For an essentially self-adjoint operator the Friedrichs extension *is* the
closure.**  A positive self-adjoint extension is in particular a self-adjoint
extension, so uniqueness identifies it with the closure of the graph; there is
nothing to choose. -/
theorem positiveExtension_eq_closure_of_esa {Dom : Submodule ℂ F} {T : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (hesa : EssentiallySelfAdjointOn D T) (hA : IsPositiveSelfAdjointExtension T A) :
    Dom = clDom T ∧ ∀ (x : F) (h : x ∈ Dom) (h' : x ∈ clDom T),
      A ⟨x, h⟩ = clExt T hdense hsym ⟨x, h'⟩ :=
  isSelfAdjointExtension_unique_of_esa hesa (isSelfAdjointExtension_of_positive hA)
    ⟨fun v => ⟨coe_mem_clDom T v, clExt_extends T hdense hsym v⟩,
      clExt_symmetricOn T hdense hsym, clExt_selfAdjointCriterion T hdense hsym hesa⟩

end Positive

/-! ## Part 5 — the Hashimoto/SIRK algorithm, with no positivity -/

section Hashimoto

variable [CompleteSpace F]

/-- **The Hashimoto/SIRK shift-invert algorithm selects the unique self-adjoint
extension of an essentially self-adjoint operator.**

This is `BookProof.HashimotoShiftInvert.hashimoto_multishift_selects_friedrichs`
with the positivity hypothesis removed: the non-real shifts make `γ_j − A`
invertible for *any* self-adjoint `A`, and essential self-adjointness on the
dense core supplies `A` (the closure) together with its uniqueness. -/
theorem hashimoto_multishift_selects_esa (b : HilbertBasis ℕ ℂ F) (T : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) (hesa : EssentiallySelfAdjointOn D T)
    (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (X : ℕ → F →L[ℂ] F),
      IsSelfAdjointExtension T A ∧
      (∀ j, IsShiftInvertC A (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : F →ₗ[ℂ] F))) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ F - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) b n u) atTop (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ F) (A' : Dom' →ₗ[ℂ] F), IsShiftInvertC A' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : F) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) := by
  obtain ⟨Dom, A, hA⟩ := exists_isSelfAdjointExtension_of_esa T hdense hsym hesa
  obtain ⟨hext, hsymA, hsa⟩ := hA
  choose X hX using fun j : ℕ =>
    exists_isShiftInvertC hsymA (hγ j) (cshiftMap_surjective hsymA hsa (hγ j))
  refine ⟨Dom, A, X, ⟨hext, hsymA, hsa⟩,
    hX, fun j => (hX j).opNorm_le hsymA (hγ j), fun j => (hX j).dom_eq_range,
    fun j k u => shiftInvertC_resolvent_identity (hX j) (hX k) u,
    fun j k => shiftInvertC_commute (hX j) (hX k),
    fun j m => shiftInvertC_comp_one_sub (hX j) (hX m),
    fun m v k => sirkDen_rkVec m hX v k,
    fun j u => galerkinCompression_tendsto (X j) b u, ?_⟩
  intro j Dom' A' hA'
  obtain ⟨hdom, hval⟩ := shiftInvertC_determines hA' (hX j)
  exact ⟨hdom, fun x hx hx' => hval x hx' hx⟩

end Hashimoto

end BookProof.EsaClosure
