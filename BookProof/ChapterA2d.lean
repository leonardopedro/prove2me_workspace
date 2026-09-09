import Mathlib
import BookProof.ChapterA
import BookProof.ChapterA1
import BookProof.ChapterA1c
import BookProof.ChapterA2

/-!
# Chapter A, §A.2 — isomorphism criteria (Prop 15), work-package N2 leftover

This file discharges the **Prop 15** leftover of work-package **N2** of
`FORMALIZATION_ROADMAP.md` (§A.2, the commutant classification): the criterion
that identifies R-real Schur systems by their complexifications.

## The framework

In the `BookProof` formalization an *R-real Schur system* is represented by a
complex Schur system `(M, V)` together with a C-conjugation `θ` (`IsConjugation`);
its *real form* is `V_θ = {x : θ x = x}`.  Here the ambient complex system `(M, V)`
plays the role of the *complexification* and the real form `V_θ` the role of the
underlying real system.

A **system isometry** `α : V ≃ₗᵢ[ℂ] W` between complex systems `(M, V)` and
`(N, W)` is a `ℂ`-linear isometric equivalence carrying `M` onto `N` by
conjugation (`N.ops = conjCLM α '' M.ops`).  Two real forms `V_{θ_M}`, `W_{θ_N}`
are isometric (as real systems) **iff** some system isometry additionally
*intertwines the conjugations* (`α ∘ θ_M = θ_N ∘ α`): such an `α` restricts to a
real-linear isometry `V_{θ_M} → W_{θ_N}`, and conversely any real isometry of
real forms complexifies to a conjugation-intertwining system isometry.

Thus **Prop 15** ("two R-real Schur systems are isometric iff their
complexifications are isometric") becomes:

> a system isometry `α : V ≃ₗᵢ[ℂ] W` exists **iff** a *conjugation-intertwining*
> system isometry exists.

The backward direction is trivial (forget the extra property).  The forward
direction is **Lemma 14** (`antiisometry_unique_up_to_phase`): the transported
conjugation `ϑ := α θ_M α⁻¹` is an anti-unitary of the Schur system `(N, W)`, so
`θ_N = c · ϑ` with `‖c‖ = 1`; rescaling `α` by a unit square root `λ` of `c`
(`λ² = c`) turns it into a conjugation-intertwining isometry.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped ComplexConjugate InnerProductSpace

namespace BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

/-! ## System isometries -/

/-- Conjugation of an operator `m : V →L[ℂ] V` by a `ℂ`-linear isometric
equivalence `α : V ≃ₗᵢ[ℂ] W`, giving `α ∘ m ∘ α⁻¹ : W →L[ℂ] W`. -/
noncomputable def conjCLM (α : V ≃ₗᵢ[ℂ] W) (m : V →L[ℂ] V) : W →L[ℂ] W :=
  (α : V →L[ℂ] W) ∘L m ∘L (α.symm : W →L[ℂ] V)

omit [CompleteSpace V] [CompleteSpace W] in
@[simp] lemma conjCLM_apply (α : V ≃ₗᵢ[ℂ] W) (m : V →L[ℂ] V) (w : W) :
    conjCLM α m w = α (m (α.symm w)) := rfl

/-- A **system isometry** between complex systems `(M, V)` and `(N, W)`: the
`ℂ`-linear isometric equivalence `α` carries `M` onto `N` by conjugation. -/
def IsSystemIso (M : System ℂ V) (N : System ℂ W) (α : V ≃ₗᵢ[ℂ] W) : Prop :=
  N.ops = conjCLM α '' M.ops

/-! ## Conjugating an anti-unitary and scaling an isometry -/

/-- The anti-unitary `α ∘ θ ∘ α⁻¹ : W ≃ₗᵢ⋆[ℂ] W` obtained by transporting an
anti-unitary `θ` of `V` along a `ℂ`-linear isometric equivalence `α : V ≃ₗᵢ[ℂ] W`. -/
noncomputable def conjAU (α : V ≃ₗᵢ[ℂ] W) (θ : AntiUnitary V) : AntiUnitary W :=
  (α.symm.trans θ).trans α

omit [CompleteSpace V] [CompleteSpace W] in
@[simp] lemma conjAU_apply (α : V ≃ₗᵢ[ℂ] W) (θ : AntiUnitary V) (w : W) :
    conjAU α θ w = α (θ (α.symm w)) := rfl

/-- Multiplication by a unit-modulus complex number is a `ℂ`-linear isometric
equivalence. -/
noncomputable def unitScaleEquiv (c : ℂ) (hc : ‖c‖ = 1) : W ≃ₗᵢ[ℂ] W :=
  have hcne : c ≠ 0 := by rintro rfl; simp at hc
  { toLinearEquiv :=
    { toFun := fun x => c • x
      map_add' := by intro x y; simp [smul_add]
      map_smul' := by intro a x; simp [smul_smul, mul_comm]
      invFun := fun x => c⁻¹ • x
      left_inv := by intro x; simp [smul_smul, hcne]
      right_inv := by intro x; simp [smul_smul, hcne] }
    norm_map' := by intro x; simp [norm_smul, hc] }

omit [CompleteSpace W] in
@[simp] lemma unitScaleEquiv_apply (c : ℂ) (hc : ‖c‖ = 1) (x : W) :
    unitScaleEquiv c hc x = c • x := rfl

/-
Every unit-modulus complex number has a unit-modulus complex square root.
-/
lemma exists_unit_sqrt (c : ℂ) (hc : ‖c‖ = 1) :
    ∃ l : ℂ, l ^ 2 = c ∧ ‖l‖ = 1 := by
  refine ⟨ c ^ ( 1 / 2 : ℂ ), ?_, ?_ ⟩ <;> norm_num [ hc ];
  · rw [ ← Complex.cpow_nat_mul ] ; norm_num;
  · rw [ Complex.norm_cpow_of_imp ] <;> aesop

/-! ## Prop 15 -/

omit [CompleteSpace V] [CompleteSpace W] in
/-
Conjugating an operator by `λ • α` gives the same result as conjugating by
`α` when `‖λ‖ = 1` (the scalar cancels).
-/
lemma conjCLM_unitScale (α : V ≃ₗᵢ[ℂ] W) (l : ℂ) (hl : ‖l‖ = 1) (m : V →L[ℂ] V) :
    conjCLM (α.trans (unitScaleEquiv l hl)) m = conjCLM α m := by
  ext x;
  -- By definition of `unitScaleEquiv`, we know that `unitScaleEquiv l hl x = l • x`.
  have h_unitScaleEquiv : (α.trans (unitScaleEquiv l hl)).symm x = (1 / l) • (α.symm x) := by
    simp only [unitScaleEquiv, LinearIsometryEquiv.symm_trans, LinearIsometryEquiv.trans_apply,
        one_div];
    exact α.symm.map_smul _ _;
  convert congr_arg ( fun y => α ( l • m y ) ) h_unitScaleEquiv using 1;
  · simp [ conjCLM, unitScaleEquiv ];
  · simp [ smul_smul, show l ≠ 0 by rintro rfl; simp at hl ]

/-
The transported conjugation `ϑ = α θ_M α⁻¹` commutes with `N` when `α` is a
system isometry and `θ_M` commutes with `M`.
-/
lemma conjAU_commutesAntiUnitary {M : System ℂ V} {N : System ℂ W} {α : V ≃ₗᵢ[ℂ] W}
    (hα : IsSystemIso M N α) {θ : AntiUnitary V} (hθ : CommutesAntiUnitary M θ) :
    CommutesAntiUnitary N (conjAU α θ) := by
  intro n hn; simp_all [ IsSystemIso, CommutesAntiUnitary ] ;
  obtain ⟨ m, hm, rfl ⟩ := hn; simp [ conjCLM_apply, hθ m hm ] ;

/-
**Prop 15 (R-real systems: isometric ⇔ complexifications isometric).**

Two R-real Schur systems — here complex Schur systems `(M, V)`, `(N, W)` with
C-conjugations `θ_M`, `θ_N` — have isometric real forms **iff** their ambient
complex systems are isometric.  Concretely: a *conjugation-intertwining* system
isometry exists **iff** a system isometry exists.

*Proof.*  Backward is immediate.  Forward: given a system isometry `α`, the
transported conjugation `ϑ := α θ_M α⁻¹` is an anti-unitary of the Schur system
`(N, W)` (`conjAU_commutesAntiUnitary`), so by Lemma 14
(`antiisometry_unique_up_to_phase`) `θ_N = c · ϑ` with `‖c‖ = 1`.  Picking a unit
square root `λ` of `c` (`exists_unit_sqrt`), the rescaled isometry
`β := λ • α` is still a system isometry (`conjCLM_unitScale`) and now intertwines
the conjugations, because `λ = conj λ · c`.
-/
theorem Rreal_isometric_iff_complexification_isometric
    (M : System ℂ V) (N : System ℂ W) (hN : IsSchurUnitary N)
    {θM : AntiUnitary V} {θN : AntiUnitary W}
    (hθM : IsConjugation M θM) (hθN : IsConjugation N θN) :
    (∃ α : V ≃ₗᵢ[ℂ] W, IsSystemIso M N α ∧ ∀ x, α (θM x) = θN (α x)) ↔
    (∃ α : V ≃ₗᵢ[ℂ] W, IsSystemIso M N α) := by
  refine ⟨ fun ⟨ α, hα, h_intertwine ⟩ => ⟨ α, hα ⟩, ?_ ⟩;
  intro h;
  obtain ⟨α, hα⟩ := h
  obtain ⟨c, hc⟩ : ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ x, θN x = c • (conjAU α θM) x := by
    exact BookProof.ChapterA.antiisometry_unique_up_to_phase N hN
      (conjAU_commutesAntiUnitary hα hθM.commutesAntiUnitary) hθN.commutesAntiUnitary
  obtain ⟨l, hl⟩ : ∃ l : ℂ, l^2 = c ∧ ‖l‖ = 1 := exists_unit_sqrt c hc.left;
  refine ⟨ α.trans ( unitScaleEquiv l hl.2 ), ?_, ?_ ⟩ <;> simp_all only [IsSystemIso, conjAU_apply,
      LinearIsometryEquiv.trans_apply, unitScaleEquiv_apply, map_smul,
          LinearIsometryEquiv.symm_apply_apply];
  · ext; simp [conjCLM_unitScale];
  · intro x; simp [ ← hl.1 ] ;
    have h_unitScaleEquiv : α (θM (l • x)) = (starRingEnd ℂ) l • α (θM x) := by
      convert α.map_smul ( starRingEnd ℂ l ) ( θM x ) using 1;
      exact congr_arg _ ( θM.map_smulₛₗ _ _ );
    simp [ h_unitScaleEquiv, sq ];
    simp [ ← smul_assoc, mul_assoc, hl.2, Complex.mul_conj, Complex.normSq_eq_norm_sq ]

end BookProof.ChapterA
