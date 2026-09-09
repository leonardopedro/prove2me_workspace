import BookProof.ChapterNonnegUnitaryGroup
import BookProof.ChapterHashimotoShiftInvert

/-!
# The resolvent of a non-negative self-adjoint relation is its Hashimoto shift-invert

`BookProof.ChapterNonnegSquareRoot` built, for a non-negative self-adjoint linear
relation `T` and every `γ > 0`, the everywhere-defined bounded resolvent
`(T + γ)⁻¹ = invCLMAt hT hγ`, and `BookProof.ChapterNonnegUnitaryGroup` built from it the
unitary group `e^{-itT}`.  `BookProof.ChapterHashimotoShiftInvert` describes the operator
the Hashimoto/SIRK shift-invert rational-Krylov algorithm actually applies to a *densely
defined operator* `A : Dom →ₗ[ℂ] F`: the shift-invert `R = (A + γ)⁻¹`, characterized by
the predicate `IsShiftInvert A γ R`.  This chapter is the bridge between the two.

* `relDomain T` is the domain of the relation and `mem_relDomain_iff` describes it;
  `snd_unique` is single-valuedness, and **`relOp hsv`** is the *operator part* of a
  single-valued relation — the honest linear map `relDomain T →ₗ[ℂ] F` whose graph is `T`
  (`relOp_mem`).
* **`isShiftInvert_invCLMAt`**: for every `γ > 0` the resolvent `(T + γ)⁻¹` **is** the
  Hashimoto shift-invert of `relOp hsv` at the shift `γ`.  So the whole shift-invert layer
  — the norm bound `‖R‖ ≤ 1/γ`, the Galerkin convergence theory, and the selection
  theorems — applies verbatim to the resolvent family of this thread.
* The unitary group of the previous chapter is therefore the dynamics of the operator the
  algorithm selects: its orbits stay in the domain (`unitaryU_mem_relDomain`), it commutes
  with the operator part (`relOp_unitaryU`), and it solves the Schrödinger equation
  `d/dt (e^{-itT} x) = -i e^{-itT} (T x)` there (`hasDerivAt_unitaryU_relOp`).
* **`unitaryU_eq_of_invCLM_eq`**: the shift-invert operator at a single shift already
  determines the unitary group — two non-negative self-adjoint relations with the same
  shift-invert generate the same `e^{-itT}`.

## Honest boundary

Nothing here is claimed about any particular physical Hamiltonian: this is the interface
statement that the resolvent family of a non-negative self-adjoint relation is exactly the
input the Hashimoto/SIRK layer consumes, and that the dynamics it determines is a unitary
group.
-/

namespace BookProof.RelationShiftInvert

open BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}

/-- The **domain** of a linear relation. -/
def relDomain (T : Submodule ℂ (F × F)) : Submodule ℂ F := T.map (LinearMap.fst ℂ F F)

omit [CompleteSpace F] in
theorem mem_relDomain_iff {x : F} : x ∈ relDomain T ↔ ∃ k : F, (x, k) ∈ T := by
  constructor
  · intro hx
    obtain ⟨p, hp, hp1⟩ := Submodule.mem_map.1 hx
    refine ⟨p.2, ?_⟩
    have hpe : p = (x, p.2) := by
      rw [← hp1]
      simp
    rwa [← hpe]
  · rintro ⟨k, hk⟩
    exact Submodule.mem_map.2 ⟨(x, k), hk, rfl⟩

omit [CompleteSpace F] in
/-- The value of a single-valued relation is unique. -/
theorem snd_unique (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {x k₁ k₂ : F}
    (h₁ : (x, k₁) ∈ T) (h₂ : (x, k₂) ∈ T) : k₁ = k₂ := by
  have hsub : ((0 : F), k₁ - k₂) ∈ T := by
    have := T.sub_mem h₁ h₂
    simpa using this
  exact sub_eq_zero.1 (hsv _ hsub)

/-- The value of the relation at a point of its domain. -/
noncomputable def relOpFun (x : relDomain T) : F :=
  Classical.choose (mem_relDomain_iff.1 x.2)

omit [CompleteSpace F] in
theorem relOpFun_mem (x : relDomain T) : ((x : F), relOpFun x) ∈ T :=
  Classical.choose_spec (mem_relDomain_iff.1 x.2)

omit [CompleteSpace F] in
theorem relOpFun_eq (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {x : relDomain T} {k : F}
    (h : ((x : F), k) ∈ T) : relOpFun x = k :=
  snd_unique hsv (relOpFun_mem x) h

/-- **The operator part of a single-valued linear relation.** -/
noncomputable def relOp (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) : relDomain T →ₗ[ℂ] F where
  toFun x := relOpFun x
  map_add' x y := by
    refine relOpFun_eq hsv ?_
    have h := T.add_mem (relOpFun_mem x) (relOpFun_mem y)
    simpa using h
  map_smul' c x := by
    refine relOpFun_eq hsv ?_
    have h := T.smul_mem c (relOpFun_mem x)
    simpa using h

omit [CompleteSpace F] in
theorem relOp_mem (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) :
    ((x : F), relOp hsv x) ∈ T := relOpFun_mem x

/-- **The resolvent `(T + γ)⁻¹` is the Hashimoto shift-invert of the operator part of `T`
at the shift `γ`** — the operator the Hashimoto/SIRK algorithm applies. -/
theorem isShiftInvert_invCLMAt (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {γ : ℝ} (hγ : 0 < γ) :
    IsShiftInvert (relOp hsv) γ (invCLMAt hT hγ) := by
  constructor
  · intro x
    refine invCLMAt_eq_of_mem hT hγ ?_
    have hx := relOp_mem hsv x
    have hrw : shiftMap (relOp hsv) γ x - (γ : ℂ) • (x : F) = relOp hsv x := by
      rw [shiftMap_apply]
      abel
    rw [hrw]
    exact hx
  · intro u
    have hmem := invCLMAt_mem hT hγ u
    have hdom : invCLMAt hT hγ u ∈ relDomain T := mem_relDomain_iff.2 ⟨_, hmem⟩
    refine ⟨hdom, ?_⟩
    have hval : relOp hsv ⟨invCLMAt hT hγ u, hdom⟩ = u - (γ : ℂ) • invCLMAt hT hγ u :=
      relOpFun_eq hsv hmem
    rw [shiftMap_apply, hval]
    abel

/-- **The Hashimoto shift-invert determines the unitary group.**  Two non-negative
self-adjoint relations whose shift-invert operators at `γ = 1` agree generate the same
unitary group `e^{-itT}`. -/
theorem unitaryU_eq_of_invCLM_eq (hT₁ : IsNonnegSelfAdjoint T₁) (hT₂ : IsNonnegSelfAdjoint T₂)
    (hsv₁ : ∀ w : F, ((0 : F), w) ∈ T₁ → w = 0) (hsv₂ : ∀ w : F, ((0 : F), w) ∈ T₂ → w = 0)
    (heq : invCLM hT₁ = invCLM hT₂) (t : ℝ) :
    unitaryU hT₁ hsv₁ t = unitaryU hT₂ hsv₂ t := by
  have hTT : T₁ = T₂ := rel_eq_of_invCLM_eq hT₁ hT₂ heq
  subst hTT
  rfl

/-! ## The unitary group of the selected operator -/

/-- The orbit of a point of the domain stays in the domain. -/
theorem unitaryU_mem_relDomain (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) (t : ℝ) :
    unitaryU hT hsv t (x : F) ∈ relDomain T :=
  mem_relDomain_iff.2 ⟨_, mem_unitaryU hT hsv (relOp_mem hsv x) t⟩

/-- **`e^{-itT}` commutes with the operator part of `T`** on its domain. -/
theorem relOp_unitaryU (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) (t : ℝ) :
    relOp hsv ⟨unitaryU hT hsv t (x : F), unitaryU_mem_relDomain hT hsv x t⟩
      = unitaryU hT hsv t (relOp hsv x) :=
  relOpFun_eq hsv (mem_unitaryU hT hsv (relOp_mem hsv x) t)

/-- **The Schrödinger equation for the operator part**:
`d/dt (e^{-itT} x) = -i e^{-itT} (T x)` for `x` in the domain. -/
theorem hasDerivAt_unitaryU_relOp (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : relDomain T) (t : ℝ) :
    HasDerivAt (fun s : ℝ => unitaryU hT hsv s (x : F))
      ((-Complex.I) • unitaryU hT hsv t (relOp hsv x)) t :=
  hasDerivAt_unitaryU hT hsv (relOp_mem hsv x) t

end BookProof.RelationShiftInvert
