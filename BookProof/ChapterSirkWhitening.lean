import Mathlib
import BookProof.ChapterH4

/-!
# Chapter SirkWhitening — the reduced operator depends only on the retained subspace

`CONSOLIDATED_PLAN.md` §12.2, **Gap 4c**: "the numerical reduction computes
`H_proj` from a whitened Gram matrix … Missing: the identity of the whitened
reduced operator with the compression `V∗XV` in the non-degenerate case."

The mathematical content of "whitening" is that *any* orthonormalization of the
raw Krylov vectors may be used: Gram whitening, Gram–Schmidt/Arnoldi, or a
Cholesky factor.  What has to be true for the numerics to be well posed is that
the answer does not depend on which one is taken.  That is what is proved here,
in the coordinate-free form: **two isometric embeddings with the same range give
unitarily equivalent compressions, and literally the same SIRK approximant on the
ambient space.**

## Deliverables

* `rangeProj` — the reconstruction operator `V ∘ V∗` of an isometric embedding.
* `rangeProj_comp_self` / `rangeProj_isSelfAdjoint` — it is the orthogonal
  projection onto the range.
* `rangeProj_eq_of_range_eq` — **two isometries with the same range have the same
  projection**.
* `whiteningEquiv` — the change-of-whitening map `W = V₂∗ ∘ V₁`, and
  `whiteningEquiv_isometry`, `whiteningEquiv_left_inverse`: it is unitary.
* `compress_conj_whitening` — **headline (Gap 4c, non-degenerate case)**: the two
  reduced operators are conjugate, `V₁∗XV₁ = W∗ (V₂∗XV₂) W`; in particular they
  have the same spectrum, the same numerical range and the same Ritz values.
* `sirkApprox_eq_of_range_eq` — and the reconstructed approximant on the ambient
  space is *identical*, so the SIRK output is independent of the whitening.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterSirkWhitening

open BookProof.ChapterH4

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]

/-! ## 1. The range projection -/

/-- The reconstruction operator `V ∘ V∗` of an isometric embedding. -/
def rangeProj (V : F →L[ℂ] E) : E →L[ℂ] E := V.comp V.adjoint

@[simp] theorem rangeProj_apply (V : F →L[ℂ] E) (u : E) :
    rangeProj V u = V (V.adjoint u) := rfl

theorem rangeProj_adjoint (V : F →L[ℂ] E) :
    ContinuousLinearMap.adjoint (rangeProj V) = rangeProj V := by
  rw [rangeProj, ContinuousLinearMap.adjoint_comp, ContinuousLinearMap.adjoint_adjoint]

theorem rangeProj_isSelfAdjoint (V : F →L[ℂ] E) : IsSelfAdjoint (rangeProj V) :=
  rangeProj_adjoint V

theorem rangeProj_comp_self (V : F →L[ℂ] E)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) :
    (rangeProj V).comp (rangeProj V) = rangeProj V := by
  ext u
  have h : V.adjoint (V (V.adjoint u)) = V.adjoint u :=
    congrArg (fun f : F →L[ℂ] F => f (V.adjoint u)) hVV
  simp [rangeProj, h]

/-- On its own range the projection is the identity. -/
theorem rangeProj_comp_embedding (V : F →L[ℂ] E)
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) (y : F) :
    rangeProj V (V y) = V y := by
  have h : V.adjoint (V y) = y := congrArg (fun f : F →L[ℂ] F => f y) hVV
  simp [rangeProj, h]

/-- If the range of `V₁` is contained in the range of `V₂`, the bigger projection
fixes the smaller one. -/
theorem rangeProj_comp_of_le (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (hle : ∀ y : F, ∃ z : G, V₁ y = V₂ z) :
    (rangeProj V₂).comp (rangeProj V₁) = rangeProj V₁ := by
  ext u
  obtain ⟨z, hz⟩ := hle (V₁.adjoint u)
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply, rangeProj_apply]
  rw [hz]
  exact rangeProj_comp_embedding V₂ hV₂ z

/-- **The projection depends only on the range.**  Two isometric embeddings with
the same range induce the same orthogonal projection — the coordinate-free form
of "any whitening of the same Krylov vectors gives the same subspace". -/
theorem rangeProj_eq_of_range_eq (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₁ : V₁.adjoint.comp V₁ = ContinuousLinearMap.id ℂ F)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z)
    (h21 : ∀ z : G, ∃ y : F, V₂ z = V₁ y) :
    rangeProj V₁ = rangeProj V₂ := by
  have hP21 : (rangeProj V₂).comp (rangeProj V₁) = rangeProj V₁ :=
    rangeProj_comp_of_le V₁ V₂ hV₂ h12
  have hP12 : (rangeProj V₁).comp (rangeProj V₂) = rangeProj V₂ :=
    rangeProj_comp_of_le V₂ V₁ hV₁ h21
  have hadj : ContinuousLinearMap.adjoint ((rangeProj V₂).comp (rangeProj V₁))
      = (rangeProj V₁).comp (rangeProj V₂) := by
    rw [ContinuousLinearMap.adjoint_comp, rangeProj_adjoint V₁, rangeProj_adjoint V₂]
  calc rangeProj V₁ = ContinuousLinearMap.adjoint (rangeProj V₁) := (rangeProj_adjoint V₁).symm
    _ = ContinuousLinearMap.adjoint ((rangeProj V₂).comp (rangeProj V₁)) := by rw [hP21]
    _ = (rangeProj V₁).comp (rangeProj V₂) := hadj
    _ = rangeProj V₂ := hP12

/-- The adjoint of a smaller embedding annihilates the orthogonal complement of the
bigger range: `V₁∗ ∘ P₂ = V₁∗` whenever `range V₁ ⊆ range V₂`. -/
theorem adjoint_comp_rangeProj (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z) :
    V₁.adjoint.comp (rangeProj V₂) = V₁.adjoint := by
  have hfix : (rangeProj V₂).comp V₁ = V₁ := by
    ext y
    obtain ⟨z, hz⟩ := h12 y
    simp only [ContinuousLinearMap.coe_comp', Function.comp_apply]
    rw [hz]
    exact rangeProj_comp_embedding V₂ hV₂ z
  calc V₁.adjoint.comp (rangeProj V₂)
      = ContinuousLinearMap.adjoint ((rangeProj V₂).comp V₁) := by
        rw [ContinuousLinearMap.adjoint_comp, rangeProj_adjoint V₂]
    _ = V₁.adjoint := by rw [hfix]

/-! ## 2. The change of whitening -/

/-- The **change-of-whitening map** `W = V₂∗ ∘ V₁` between the two coordinate
spaces of two embeddings of the same subspace. -/
def whiteningEquiv (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E) : F →L[ℂ] G :=
  V₂.adjoint.comp V₁

omit [CompleteSpace F] in
theorem embedding_comp_whiteningEquiv (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z) (y : F) :
    V₂ (whiteningEquiv V₁ V₂ y) = V₁ y := by
  obtain ⟨z, hz⟩ := h12 y
  have h : V₂.adjoint (V₂ z) = z := congrArg (fun f : G →L[ℂ] G => f z) hV₂
  simp only [whiteningEquiv, ContinuousLinearMap.coe_comp', Function.comp_apply]
  rw [hz, h]

omit [CompleteSpace F] in
/-- The change of whitening is an isometry. -/
theorem whiteningEquiv_isometry (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₁ : ∀ y : F, ‖V₁ y‖ = ‖y‖) (hV₂ : ∀ z : G, ‖V₂ z‖ = ‖z‖)
    (hV₂adj : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z) (y : F) :
    ‖whiteningEquiv V₁ V₂ y‖ = ‖y‖ := by
  have := embedding_comp_whiteningEquiv V₁ V₂ hV₂adj h12 y
  rw [← hV₂ (whiteningEquiv V₁ V₂ y), this, hV₁]

/-- The two changes of whitening are mutually inverse. -/
theorem whiteningEquiv_left_inverse (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E)
    (hV₁ : V₁.adjoint.comp V₁ = ContinuousLinearMap.id ℂ F)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z) (y : F) :
    whiteningEquiv V₂ V₁ (whiteningEquiv V₁ V₂ y) = y := by
  have h := embedding_comp_whiteningEquiv V₁ V₂ hV₂ h12 y
  have h' : V₁.adjoint (V₁ y) = y := congrArg (fun f : F →L[ℂ] F => f y) hV₁
  change V₁.adjoint (V₂ (whiteningEquiv V₁ V₂ y)) = y
  rw [h, h']

/-! ## 3. Whitening independence of the reduced operator -/

/-- **Headline (Gap 4c).**  The reduced operators produced by two whitenings of
the same retained subspace are conjugate by the unitary change of whitening:
`V₁∗XV₁ = W∗ (V₂∗XV₂) W` with `W = V₂∗V₁`.  Hence they have the same spectrum,
the same numerical range and the same Ritz values — the reduction is a property
of the subspace, not of the basis chosen for it. -/
theorem compress_conj_whitening (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E) (X : E →L[ℂ] E)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z) :
    compress V₁ X
      = (whiteningEquiv V₂ V₁).comp ((compress V₂ X).comp (whiteningEquiv V₁ V₂)) := by
  have hproj := adjoint_comp_rangeProj V₁ V₂ hV₂ h12
  ext y
  have hy : V₂ (whiteningEquiv V₁ V₂ y) = V₁ y :=
    embedding_comp_whiteningEquiv V₁ V₂ hV₂ h12 y
  have hstep : V₁.adjoint (rangeProj V₂ (X (V₁ y))) = V₁.adjoint (X (V₁ y)) :=
    congrArg (fun f : E →L[ℂ] F => f (X (V₁ y))) hproj
  change V₁.adjoint (X (V₁ y))
    = V₁.adjoint (V₂ (V₂.adjoint (X (V₂ (whiteningEquiv V₁ V₂ y)))))
  rw [hy]
  exact hstep.symm

/-- **The SIRK output itself is whitening-independent.**  Reduce, propagate with
the compression, reconstruct: the resulting operator on the ambient space is
literally the same for two whitenings of the same subspace, because it is
`P X P` for the range projection `P`. -/
theorem compress_reconstruct_eq (V : F →L[ℂ] E) (X : E →L[ℂ] E) :
    V.comp ((compress V X).comp V.adjoint) = (rangeProj V).comp (X.comp (rangeProj V)) := by
  ext u
  simp [compress, rangeProj]

/-- Two whitenings of the same retained subspace produce the same reconstructed
SIRK operator. -/
theorem sirkApprox_eq_of_range_eq (V₁ : F →L[ℂ] E) (V₂ : G →L[ℂ] E) (X : E →L[ℂ] E)
    (hV₁ : V₁.adjoint.comp V₁ = ContinuousLinearMap.id ℂ F)
    (hV₂ : V₂.adjoint.comp V₂ = ContinuousLinearMap.id ℂ G)
    (h12 : ∀ y : F, ∃ z : G, V₁ y = V₂ z)
    (h21 : ∀ z : G, ∃ y : F, V₂ z = V₁ y) :
    V₁.comp ((compress V₁ X).comp V₁.adjoint)
      = V₂.comp ((compress V₂ X).comp V₂.adjoint) := by
  rw [compress_reconstruct_eq, compress_reconstruct_eq,
    rangeProj_eq_of_range_eq V₁ V₂ hV₁ hV₂ h12 h21]

end BookProof.ChapterSirkWhitening
