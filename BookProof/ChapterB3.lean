import Mathlib

/-!
# Chapter B §B.3 — Partial-isometry API (work-package N3 residue)

Source: `book.tex` §3 / `FORMALIZATION_ROADMAP.md` §B.3(b).  The singular-value
expansion `Ψ = W D U†` of the Hilbert–Schmidt kernel operator produces a
*partial isometry* `V` (padded to a unitary `W`).  The book records the
defining algebraic relations of a partial isometry — that `V†V` and `VV†` are
orthogonal projections and that `V V† V = V`.  Mathlib has no `PartialIsometry`
for operators (only the metric-space `Isometry`), so this file builds the small
self-contained operator-theoretic API requested as the N3 residue:

* `IsPartialIsometry V` — the defining relation `V ∘L V† ∘L V = V`;
* `IsPartialIsometry.adjointComp_isSelfAdjoint` / `_isIdempotent` — `V†V` is an
  orthogonal projection (self-adjoint idempotent);
* `IsPartialIsometry.compAdjoint_isSelfAdjoint` / `_isIdempotent` — `VV†` is an
  orthogonal projection;
* `IsPartialIsometry.adjoint` — the adjoint of a partial isometry is a partial
  isometry (`V† V V† = V†`);
* `isPartialIsometry_iff_adjointComp_isIdempotent` — the equivalence with `V†V`
  being a projection (the usual textbook characterization).

Everything is `sorry`-free and axiom-clean (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open ContinuousLinearMap
open scoped InnerProductSpace

namespace BookProof.ChapterB3

variable {𝕜 : Type*} [RCLike 𝕜]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace 𝕜 H] [CompleteSpace H]

/-- A continuous linear operator `V` on a Hilbert space is a **partial isometry**
when it satisfies the defining relation `V V† V = V`.  Equivalently (see
`isPartialIsometry_iff_adjointComp_isIdempotent`) the operator `V†V` is an
orthogonal projection; `V` is then an isometry on `(ker V)ᗮ = ran V†` and zero on
`ker V`. -/
def IsPartialIsometry (V : H →L[𝕜] H) : Prop :=
  V ∘L (adjoint V) ∘L V = V

/-- `V†V` is always self-adjoint, for any operator `V`. -/
theorem adjointComp_isSelfAdjoint (V : H →L[𝕜] H) :
    IsSelfAdjoint (adjoint V ∘L V) := by
  rw [IsSelfAdjoint, ContinuousLinearMap.star_eq_adjoint, adjoint_comp, adjoint_adjoint]

/-- `VV†` is always self-adjoint, for any operator `V`. -/
theorem compAdjoint_isSelfAdjoint (V : H →L[𝕜] H) :
    IsSelfAdjoint (V ∘L adjoint V) := by
  rw [IsSelfAdjoint, ContinuousLinearMap.star_eq_adjoint, adjoint_comp, adjoint_adjoint]

/-- Pointwise form of the partial-isometry relation: `V (V† (V y)) = V y`. -/
theorem IsPartialIsometry.apply (V : H →L[𝕜] H) (hV : IsPartialIsometry V) (y : H) :
    V (adjoint V (V y)) = V y := by
  have := congrArg (fun (T : H →L[𝕜] H) => T y) hV
  simpa using this

/-- For a partial isometry, `V†V` is idempotent — hence (with
`adjointComp_isSelfAdjoint`) an orthogonal projection. -/
theorem IsPartialIsometry.adjointComp_isIdempotent (V : H →L[𝕜] H)
    (hV : IsPartialIsometry V) : IsIdempotentElem (adjoint V ∘L V) := by
  rw [IsIdempotentElem, ContinuousLinearMap.mul_def]
  ext x
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply]
  rw [hV.apply V x]

/-- For a partial isometry, `VV†` is idempotent — hence (with
`compAdjoint_isSelfAdjoint`) an orthogonal projection. -/
theorem IsPartialIsometry.compAdjoint_isIdempotent (V : H →L[𝕜] H)
    (hV : IsPartialIsometry V) : IsIdempotentElem (V ∘L adjoint V) := by
  rw [IsIdempotentElem, ContinuousLinearMap.mul_def]
  ext x
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply]
  rw [hV.apply V (adjoint V x)]

/-- The adjoint of a partial isometry is a partial isometry: `V† V V† = V†`. -/
theorem IsPartialIsometry.adjoint (V : H →L[𝕜] H) (hV : IsPartialIsometry V) :
    IsPartialIsometry (adjoint V) := by
  unfold IsPartialIsometry at hV ⊢
  rw [adjoint_adjoint]
  have := congrArg ContinuousLinearMap.adjoint hV
  rw [adjoint_comp, adjoint_comp, adjoint_adjoint] at this
  -- `this : (adjoint V ∘L V) ∘L adjoint V = adjoint V`; reassociate to the goal.
  rw [← ContinuousLinearMap.comp_assoc]
  exact this

/-- Converse: if `V†V` is idempotent (a projection) then `V` is a partial
isometry.  This is the standard textbook characterization; the proof is the
`‖V(1 - V†V)x‖² = ⟨(1-V†V)x, (V†V)(1-V†V)x⟩ = 0` computation. -/
theorem isPartialIsometry_of_adjointComp_isIdempotent (V : H →L[𝕜] H)
    (hP : IsIdempotentElem (adjoint V ∘L V)) : IsPartialIsometry V := by
  unfold IsPartialIsometry
  ext x
  have hzero : (adjoint V ∘L V) ((adjoint V ∘L V) x - x) = 0 := by
    rw [map_sub]
    have h2 : ((adjoint V ∘L V) * (adjoint V ∘L V)) x = (adjoint V ∘L V) x := by
      rw [hP.eq]
    rw [ContinuousLinearMap.mul_apply] at h2
    rw [h2]; simp
  have hnormsq :
      (⟪V ((adjoint V ∘L V) x - x), V ((adjoint V ∘L V) x - x)⟫_𝕜) = 0 := by
    rw [← ContinuousLinearMap.adjoint_inner_right]
    have hcoe : (adjoint V) (V ((adjoint V ∘L V) x - x))
        = (adjoint V ∘L V) ((adjoint V ∘L V) x - x) := rfl
    rw [hcoe, hzero, inner_zero_right]
  have hy : V ((adjoint V ∘L V) x - x) = 0 := by
    rwa [inner_self_eq_zero] at hnormsq
  rw [map_sub] at hy
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at *
  exact sub_eq_zero.mp hy

/-- A partial isometry is **norm-preserving on its initial space**: whenever
`V†V x = x` (i.e. `x` lies in the range of the projection `V†V`, the orthogonal
complement of `ker V`), then `‖V x‖ = ‖x‖`.  This is the geometric content of a
partial isometry — it is an isometry on `(ker V)ᗮ` and vanishes on `ker V`.
No partial-isometry hypothesis is even needed for this pointwise statement. -/
theorem norm_map_of_adjointComp_eq (V : H →L[𝕜] H) (x : H)
    (hx : (adjoint V ∘L V) x = x) : ‖V x‖ = ‖x‖ := by
  have h1 : ⟪V x, V x⟫_𝕜 = ⟪x, x⟫_𝕜 := by
    rw [← ContinuousLinearMap.adjoint_inner_right, show (adjoint V) (V x) = x from hx]
  have h2 : (‖V x‖ : ℝ) ^ 2 = ‖x‖ ^ 2 := by
    rw [@inner_self_eq_norm_sq_to_K 𝕜, @inner_self_eq_norm_sq_to_K 𝕜] at h1
    exact_mod_cast h1
  nlinarith [norm_nonneg (V x), norm_nonneg x, h2]

/-- The textbook characterization: `V` is a partial isometry **iff** `V†V` is an
orthogonal projection (equivalently, idempotent, since `V†V` is automatically
self-adjoint). -/
theorem isPartialIsometry_iff_adjointComp_isIdempotent (V : H →L[𝕜] H) :
    IsPartialIsometry V ↔ IsIdempotentElem (adjoint V ∘L V) :=
  ⟨IsPartialIsometry.adjointComp_isIdempotent V,
    isPartialIsometry_of_adjointComp_isIdempotent V⟩

/-! ## B.3c — the conditional-operator identity (change of marginal = conjugation)

`FORMALIZATION_ROADMAP.md` §B.3c records the algebraic identity that turns a
change of reference marginal `p₀ → p` into conjugation of the singular-value
factorization `Ψ = W D U†`: with `R` the (self-adjoint, positive) multiplication
operator by the density ratio `p/p₀`,
`T p T† = Ψ (p/p₀) Ψ† = W D U† (p/p₀) U D W†`.

The purely operator-algebraic core (the substitution `Ψ = W D U†`, using
`Ψ† = U D W†` because `D` is self-adjoint) is the following identity.  The
compact-operator singular-value expansion `denseCore_svd` producing the concrete
`W, D, U` from a Hilbert–Schmidt `Ψ` requires compact-operator spectral theory not
present in Mathlib and remains the recorded open residue of N3. -/
theorem conditional_operator_identity (W U D R Ψ : H →L[𝕜] H)
    (hD : IsSelfAdjoint D) (hΨ : Ψ = W ∘L D ∘L adjoint U) :
    Ψ ∘L R ∘L adjoint Ψ
      = W ∘L D ∘L adjoint U ∘L R ∘L U ∘L D ∘L adjoint W := by
  have hDadj : adjoint D = D := by
    simpa [ContinuousLinearMap.star_eq_adjoint] using hD
  subst hΨ
  simp only [adjoint_comp, adjoint_adjoint, hDadj]
  ext x
  simp [ContinuousLinearMap.comp_assoc]

end BookProof.ChapterB3
