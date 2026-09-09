import Mathlib
import BookProof.ChapterHashimotoShiftInvert

/-!
# The Friedrichs extension of an **unbounded** positive symmetric operator

`CONSOLIDATED_PLAN.md` §11.4 records two plan items that stand between the proved
Hashimoto/shift-invert machinery and the full claim *"the unbounded continuum
Weyl-gauge Hamiltonian has a Friedrichs extension, and the infinite
Hashimoto/SIRK limit selects exactly it"*.  This module closes the first one.

Until now the Friedrichs theorem entered the project in two forms:

* as a **named hypothesis**
  (`BookProof.YangMillsFriedrichs.friedrichs_extension_of_semibounded`), shown
  consistent only for an operator already defined on the whole space;
* **discharged by construction, but only in the bounded regime**
  (`BookProof.YangMillsFriedrichsLimit.friedrichs_of_bounded`: a densely defined
  symmetric positive operator with `‖H x‖ ≤ C‖x‖` extends continuously).

Here the theorem is **proved with no boundedness hypothesis at all**: every
densely defined, symmetric, positive operator on a complex Hilbert space has a
positive self-adjoint extension.  The construction is the classical one, carried
out in full:

**Part A — the form space.**  The domain carries the *form inner product*
`⟪x, y⟫₁ = ⟪x, y⟫ + ⟪x, H y⟫`.  Symmetry makes it Hermitian and positivity makes
it positive definite (indeed `‖x‖ ≤ ‖x‖₁`), so `FormDom P` — the domain retyped
with that inner product — is an inner product space (`instCore`, `instIPS`), and
`FormSpace P`, its completion, is a Hilbert space.

**Part B — the form space sits inside `F`.**  The inclusion `FormDom P → F` is
norm-decreasing, so it extends to `formExt P : FormSpace P →L[ℂ] F`.  The key
identity `inner_coe_eq` — `⟪x, k⟫₁ = ⟪x + H x, formExt k⟫` for a domain vector
`x` — is the closability of the form in disguise, and it gives
`formExt_injective`: *the form completion adds no ghost vectors*.  This is the
one place where symmetry and positivity of `H` do analytic work.

**Part C — Riesz representation.**  For `u : F` the functional
`k ↦ ⟪u, formExt k⟫` is continuous on the Hilbert space `FormSpace P`, so it is
represented by a vector `formRiesz P u`, and
`friedrichsResolvent P u = formExt P (formRiesz P u)` is a bounded, injective,
positive, self-adjoint operator on `F` with `‖·‖ ≤ 1`.  It is `(H + 1)⁻¹` on the
nose: `friedrichsResolvent_shift` proves `S (x + H x) = x` for every `x` in the
domain.

**Part D — the extension.**  Feeding `S` to the project's own converse
construction `BookProof.HashimotoShiftInvert.invShiftOperator` (`A = S⁻¹ − 1`)
produces the extension, and `friedrichs_extension_exists` states it in the form
the rest of the project consumes,
`BookProof.YangMillsFriedrichs.IsPositiveSelfAdjointExtension`.  Consequences:

* `friedrichs_hypothesis_holds` — the named hypothesis of
  `friedrichs_extension_of_semibounded` is a theorem, not an assumption;
* `friedrichs_extension_of_semibounded_below` — the classical statement, for a
  symmetric operator that is merely *bounded below* (`⟪x, Hx⟫ ≥ −c‖x‖²`), by the
  shift `H ↦ H + c`;
* `weyl_friedrichs_extension_unconditional` — the Weyl-gauge Yang–Mills
  Hamiltonian `½ Σ πᵢ² + ½ Σ Bₐ²` on any dense domain has a Friedrichs
  extension, with **no boundedness hypothesis** (plan item §11.4.1);
* `weyl_hashimoto_selects_friedrichs` — combining with
  `hashimoto_shiftInvert_selects_friedrichs`: in the occupation-number (Hermite)
  realization the extension *exists* and the Hashimoto/SIRK algorithm converges
  to it and to nothing else;
* `unbounded_friedrichs_example` — the construction applied to a genuinely
  unbounded operator (`A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)`, restricted to the finite-mode
  domain), so nothing here is vacuous.

## Scope

This is the abstract Friedrichs theorem and its application to the Weyl-gauge
Hamiltonian *as an operator on a Hilbert space*.  It does **not** claim the mass
gap, nor a differential (field-space) realization of the magnetic-field operator
`B_{i a}` — that is the second, definitional item of §11.4, settled there in
favour of the occupation-number/Hermite realization.
-/

namespace BookProof.FriedrichsExtension

open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- A **densely definable positive symmetric operator**, bundled so that the form
inner product can be attached to its domain as a type-class structure. -/
structure PosSymOp (F : Type*) [NormedAddCommGroup F] [InnerProductSpace ℂ F] where
  /-- The domain of the operator. -/
  dom : Submodule ℂ F
  /-- The operator itself. -/
  op : dom →ₗ[ℂ] F
  /-- The operator is symmetric on its domain. -/
  sym : SymmetricOn dom op
  /-- The operator is positive: its quadratic form is nonnegative. -/
  pos : ∀ x : dom, 0 ≤ quadForm op x

theorem re_inner_self (v : F) : (inner ℂ v v : ℂ).re = ‖v‖ ^ 2 := by
  simp [← Complex.ofReal_pow]

/-! ## Part A — the domain with its form inner product -/

/-- The domain of `P`, retyped so that it carries the **form inner product**
`⟪x, y⟫₁ = ⟪x, y⟫ + ⟪x, H y⟫` instead of the ambient one. -/
def FormDom (P : PosSymOp F) : Type _ := P.dom

namespace FormDom

instance (P : PosSymOp F) : AddCommGroup (FormDom P) := inferInstanceAs (AddCommGroup P.dom)

instance (P : PosSymOp F) : Module ℂ (FormDom P) := inferInstanceAs (Module ℂ P.dom)

/-- The underlying domain vector. -/
def toDom {P : PosSymOp F} (x : FormDom P) : P.dom := x

/-- The underlying ambient vector. -/
def toAmbient {P : PosSymOp F} (x : FormDom P) : F := (toDom x : F)

theorem toAmbient_eq {P : PosSymOp F} (x : FormDom P) :
    toAmbient x = ((toDom x : P.dom) : F) := rfl

@[simp] theorem toAmbient_add {P : PosSymOp F} (x y : FormDom P) :
    toAmbient (x + y) = toAmbient x + toAmbient y := rfl

@[simp] theorem toAmbient_smul {P : PosSymOp F} (r : ℂ) (x : FormDom P) :
    toAmbient (r • x) = r • toAmbient x := rfl

theorem toDom_injective {P : PosSymOp F} : Function.Injective (toDom (P := P)) := fun _ _ h => h

noncomputable instance instInner (P : PosSymOp F) : Inner ℂ (FormDom P) :=
  ⟨fun x y => inner ℂ (toAmbient x) (toAmbient y) + inner ℂ (toAmbient x) (P.op (toDom y))⟩

theorem inner_def {P : PosSymOp F} (x y : FormDom P) :
    (inner ℂ x y : ℂ) = inner ℂ (toAmbient x) (toAmbient y)
      + inner ℂ (toAmbient x) (P.op (toDom y)) := rfl

/-- The form of a positive symmetric operator **is an inner product**: Hermitian
by symmetry of `H`, positive definite because it dominates the ambient norm. -/
noncomputable instance instCore (P : PosSymOp F) : InnerProductSpace.Core ℂ (FormDom P) where
  conj_inner_symm x y := by
    rw [inner_def, inner_def]
    simp only [map_add]
    rw [inner_conj_symm]
    congr 1
    rw [toAmbient_eq, toAmbient_eq, ← P.sym (toDom x) (toDom y), inner_conj_symm]
  re_inner_nonneg x := by
    change 0 ≤ ((inner ℂ x x : ℂ)).re
    rw [inner_def, Complex.add_re, re_inner_self]
    have hp := P.pos (toDom x)
    rw [quadForm, ← toAmbient_eq] at hp
    positivity
  add_left x y z := by
    rw [inner_def, inner_def, inner_def, toAmbient_add, inner_add_left, inner_add_left]
    ring
  smul_left x y r := by
    rw [inner_def, inner_def, toAmbient_smul, inner_smul_left, inner_smul_left]
    ring
  definite x hx := by
    have hre : ((inner ℂ x x : ℂ)).re = 0 := by rw [hx]; simp
    rw [inner_def, Complex.add_re, re_inner_self] at hre
    have hp := P.pos (toDom x)
    rw [quadForm, ← toAmbient_eq] at hp
    have hn : ‖toAmbient x‖ = 0 := by nlinarith [norm_nonneg (toAmbient x)]
    apply toDom_injective
    apply Subtype.ext
    exact (by simpa using hn : toAmbient x = 0)

noncomputable instance instNormed (P : PosSymOp F) : NormedAddCommGroup (FormDom P) :=
  InnerProductSpace.Core.toNormedAddCommGroup (cd := instCore P)

noncomputable instance instIPS (P : PosSymOp F) : InnerProductSpace ℂ (FormDom P) := .ofCore _

theorem norm_sq_eq {P : PosSymOp F} (x : FormDom P) :
    ‖x‖ ^ 2 = ‖toAmbient x‖ ^ 2 + (inner ℂ (toAmbient x) (P.op (toDom x)) : ℂ).re := by
  have h : ‖x‖ ^ 2 = ((inner ℂ x x : ℂ)).re := (re_inner_self (F := FormDom P) x).symm
  rw [h, inner_def, Complex.add_re, re_inner_self]

/-- **The form norm dominates the ambient norm**, `‖x‖ ≤ ‖x‖₁`. -/
theorem norm_toAmbient_le {P : PosSymOp F} (x : FormDom P) : ‖toAmbient x‖ ≤ ‖x‖ := by
  have h := norm_sq_eq x
  have hp := P.pos (toDom x)
  rw [quadForm, ← toAmbient_eq] at hp
  nlinarith [norm_nonneg (toAmbient x), norm_nonneg x]

/-- The inclusion of the form domain into the ambient space. -/
def inclLin (P : PosSymOp F) : FormDom P →ₗ[ℂ] F where
  toFun := toAmbient
  map_add' := toAmbient_add
  map_smul' := toAmbient_smul

/-- The inclusion as a continuous linear map of norm at most one. -/
noncomputable def incl (P : PosSymOp F) : FormDom P →L[ℂ] F :=
  (inclLin P).mkContinuous 1 (fun x => by simpa using norm_toAmbient_le x)

@[simp] theorem incl_apply {P : PosSymOp F} (x : FormDom P) : incl P x = toAmbient x := rfl

theorem norm_incl_le (P : PosSymOp F) : ‖incl P‖ ≤ 1 :=
  LinearMap.mkContinuous_norm_le _ zero_le_one _

end FormDom

/-! ## Part B — the form completion and its embedding into `F` -/

/-- **The form space**: the completion of the domain in the form norm.  This is
the form domain of the Friedrichs extension. -/
abbrev FormSpace (P : PosSymOp F) : Type _ := UniformSpace.Completion (FormDom P)

namespace FormDom

theorem denseRange_toComplL (P : PosSymOp F) :
    DenseRange (UniformSpace.Completion.toComplL (𝕜 := ℂ) (E := FormDom P)) := by
  simpa [UniformSpace.Completion.coe_toComplL] using
    UniformSpace.Completion.denseRange_coe (α := FormDom P)

theorem isUniformInducing_toComplL (P : PosSymOp F) :
    IsUniformInducing (UniformSpace.Completion.toComplL (𝕜 := ℂ) (E := FormDom P)) := by
  simpa [UniformSpace.Completion.coe_toComplL] using
    UniformSpace.Completion.isUniformInducing_coe (FormDom P)

variable [CompleteSpace F]

/-- The inclusion of the form domain into `F`, extended to the form completion. -/
noncomputable def formExt (P : PosSymOp F) : FormSpace P →L[ℂ] F :=
  (incl P).extend UniformSpace.Completion.toComplL

@[simp] theorem formExt_coe (P : PosSymOp F) (x : FormDom P) :
    formExt P (x : FormSpace P) = toAmbient x := by
  have := ContinuousLinearMap.extend_eq (incl P) (denseRange_toComplL P)
    (isUniformInducing_toComplL P) x
  simpa [formExt, UniformSpace.Completion.coe_toComplL] using this

theorem norm_formExt_le (P : PosSymOp F) : ‖formExt P‖ ≤ 1 := by
  have h : ‖(incl P).extend (UniformSpace.Completion.toComplL (𝕜 := ℂ) (E := FormDom P))‖
      ≤ (1 : NNReal) * ‖incl P‖ :=
    ContinuousLinearMap.opNorm_extend_le _ (denseRange_toComplL P)
      (fun x => by simp [UniformSpace.Completion.coe_toComplL])
  have := le_trans h (by simpa using norm_incl_le P)
  simpa [formExt] using this

theorem norm_formExt_apply_le (P : PosSymOp F) (k : FormSpace P) : ‖formExt P k‖ ≤ ‖k‖ := by
  have := (formExt P).le_opNorm k
  nlinarith [norm_formExt_le P, norm_nonneg k, norm_nonneg (formExt P k)]

/-- **The key identity of the form space.**  Pairing with (the image of) a domain
vector `x` in the *form* inner product is pairing with `x + H x` in the ambient
one.  Everything analytic about the construction — closability of the form —
is contained in this one line. -/
theorem inner_coe_eq (P : PosSymOp F) (x : FormDom P) (k : FormSpace P) :
    (inner ℂ (x : FormSpace P) k : ℂ)
      = inner ℂ (toAmbient x + P.op (toDom x)) (formExt P k) := by
  refine UniformSpace.Completion.induction_on k ?_ ?_
  · exact isClosed_eq (by fun_prop) (by fun_prop)
  · intro y
    rw [formExt_coe, UniformSpace.Completion.inner_coe, inner_def, inner_add_left,
      toAmbient_eq, toAmbient_eq, P.sym (toDom x) (toDom y)]

/-- **The form completion embeds into the ambient space**: the form has no ghost
elements.  This is the closability of the form of a positive symmetric
operator. -/
theorem formExt_injective (P : PosSymOp F) : Function.Injective (formExt P) := by
  rw [injective_iff_map_eq_zero]
  intro k hk
  have hzero : ∀ y : FormDom P, (inner ℂ (y : FormSpace P) k : ℂ) = 0 := by
    intro y
    rw [inner_coe_eq, hk, inner_zero_right]
  have hall : ∀ z : FormSpace P, (inner ℂ z k : ℂ) = 0 := by
    intro z
    refine UniformSpace.Completion.induction_on z ?_ hzero
    exact isClosed_eq (by fun_prop) (by fun_prop)
  simpa using hall k

theorem dense_range_formExt (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    Dense (Set.range (formExt P)) := by
  refine Dense.mono ?_ hdense
  intro v hv
  exact ⟨((show FormDom P from ⟨v, hv⟩ : FormDom P) : FormSpace P), by rw [formExt_coe]; rfl⟩

end FormDom

/-! ## Part C — Riesz representation: the resolvent `(H + 1)⁻¹` -/

namespace FormDom

variable [CompleteSpace F]

/-- The **Riesz vector** of `u : F` in the form space: the unique `g` with
`⟪g, k⟫₁ = ⟪u, formExt k⟫` for every `k`. -/
noncomputable def formRiesz (P : PosSymOp F) (u : F) : FormSpace P :=
  (InnerProductSpace.toDual ℂ (FormSpace P)).symm ((innerSL ℂ u).comp (formExt P))

theorem formRiesz_spec (P : PosSymOp F) (u : F) (k : FormSpace P) :
    (inner ℂ (formRiesz P u) k : ℂ) = inner ℂ u (formExt P k) := by
  rw [formRiesz, InnerProductSpace.toDual_symm_apply]
  simp

theorem formRiesz_add (P : PosSymOp F) (u v : F) :
    formRiesz P (u + v) = formRiesz P u + formRiesz P v := by
  refine ext_inner_right ℂ (fun k => ?_)
  rw [formRiesz_spec, inner_add_left, inner_add_left, formRiesz_spec, formRiesz_spec]

theorem formRiesz_smul (P : PosSymOp F) (c : ℂ) (u : F) :
    formRiesz P (c • u) = c • formRiesz P u := by
  refine ext_inner_right ℂ (fun k => ?_)
  rw [formRiesz_spec, inner_smul_left, inner_smul_left, formRiesz_spec]

theorem norm_formRiesz_le (P : PosSymOp F) (u : F) : ‖formRiesz P u‖ ≤ ‖u‖ := by
  have h1 : ‖formRiesz P u‖ ^ 2 = (inner ℂ (formRiesz P u) (formRiesz P u) : ℂ).re :=
    (re_inner_self (F := FormSpace P) _).symm
  rw [formRiesz_spec] at h1
  have h3 : (inner ℂ u (formExt P (formRiesz P u)) : ℂ).re ≤ ‖u‖ * ‖formRiesz P u‖ :=
    le_trans (Complex.re_le_norm _) (le_trans (norm_inner_le_norm _ _)
      (mul_le_mul_of_nonneg_left (norm_formExt_apply_le P _) (norm_nonneg u)))
  nlinarith [norm_nonneg (formRiesz P u), norm_nonneg u]

/-- **The resolvent of the Friedrichs extension at `−1`**, `S = (H + 1)⁻¹`,
built by Riesz representation in the form space. -/
noncomputable def friedrichsResolvent (P : PosSymOp F) : F →L[ℂ] F :=
  LinearMap.mkContinuous
    { toFun := fun u => formExt P (formRiesz P u)
      map_add' := fun u v => by rw [formRiesz_add, map_add]
      map_smul' := fun c u => by rw [formRiesz_smul, map_smul]; rfl } 1
    (fun u => by
      simpa using le_trans (norm_formExt_apply_le P (formRiesz P u)) (norm_formRiesz_le P u))

@[simp] theorem friedrichsResolvent_apply (P : PosSymOp F) (u : F) :
    friedrichsResolvent P u = formExt P (formRiesz P u) := rfl

theorem inner_friedrichsResolvent (P : PosSymOp F) (u v : F) :
    (inner ℂ u (friedrichsResolvent P v) : ℂ) = inner ℂ (formRiesz P u) (formRiesz P v) := by
  rw [friedrichsResolvent_apply, formRiesz_spec]

/-- `S` is self-adjoint. -/
theorem friedrichsResolvent_isSelfAdjoint (P : PosSymOp F) :
    IsSelfAdjoint (friedrichsResolvent P) := by
  rw [ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric]
  intro u v
  simp only [ContinuousLinearMap.coe_coe]
  rw [← inner_conj_symm, inner_friedrichsResolvent, inner_friedrichsResolvent, inner_conj_symm]

/-- `S ≤ 1` in the sense of quadratic forms — the positivity hypothesis of the
shift-invert construction at `γ = 1`. -/
theorem friedrichsResolvent_pos (P : PosSymOp F) (u : F) :
    (1 : ℝ) * ‖friedrichsResolvent P u‖ ^ 2
      ≤ (inner ℂ (friedrichsResolvent P u) u : ℂ).re := by
  have h : (inner ℂ (friedrichsResolvent P u) u : ℂ)
      = starRingEnd ℂ (inner ℂ u (friedrichsResolvent P u)) := (inner_conj_symm _ _).symm
  rw [h, inner_friedrichsResolvent]
  have h2 : (inner ℂ (formRiesz P u) (formRiesz P u) : ℂ) = ((‖formRiesz P u‖ ^ 2 : ℝ) : ℂ) := by
    simp [inner_self_eq_norm_sq_to_K, Complex.ofReal_pow]
  rw [h2]
  simp only [Complex.conj_ofReal, Complex.ofReal_re, one_mul, friedrichsResolvent_apply]
  nlinarith [norm_formExt_apply_le P (formRiesz P u), norm_nonneg (formExt P (formRiesz P u)),
    norm_nonneg (formRiesz P u)]

/-- `S` is injective — using that the domain is dense in `F`. -/
theorem friedrichsResolvent_injective (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    Function.Injective (friedrichsResolvent P) := by
  rw [injective_iff_map_eq_zero]
  intro u hu
  have h0 : formRiesz P u = 0 := formExt_injective P (by simpa using hu)
  have hall : ∀ k : FormSpace P, (inner ℂ u (formExt P k) : ℂ) = 0 := by
    intro k
    rw [← formRiesz_spec, h0, inner_zero_left]
  have hzero : ∀ v : F, (inner ℂ u v : ℂ) = 0 := by
    intro v
    have hc : Continuous fun w : F => (inner ℂ u w : ℂ) := (innerSL ℂ u).continuous
    have heq : Set.EqOn (fun w : F => (inner ℂ u w : ℂ)) (fun _ => (0 : ℂ))
        (Set.range (formExt P)) := by
      rintro _ ⟨k, rfl⟩
      exact hall k
    exact congrFun (Continuous.ext_on (dense_range_formExt P hdense) hc continuous_const heq) v
  simpa using hzero u

/-- **`S` really is `(H + 1)⁻¹`**: it sends `x + H x` back to `x`, for every `x`
in the domain of `H`. -/
theorem friedrichsResolvent_shift (P : PosSymOp F) (x : P.dom) :
    friedrichsResolvent P ((x : F) + P.op x) = (x : F) := by
  have hx : formRiesz P ((x : F) + P.op x)
      = ((show FormDom P from x : FormDom P) : FormSpace P) := by
    refine ext_inner_right ℂ (fun k => ?_)
    rw [formRiesz_spec, inner_coe_eq]
    rfl
  rw [friedrichsResolvent_apply, hx, formExt_coe]
  rfl

theorem dom_le_range (P : PosSymOp F) :
    P.dom ≤ LinearMap.range (friedrichsResolvent P : F →ₗ[ℂ] F) := by
  intro v hv
  exact ⟨(v : F) + P.op ⟨v, hv⟩, friedrichsResolvent_shift P ⟨v, hv⟩⟩

end FormDom

/-! ## Part D — the Friedrichs extension theorem, with no boundedness -/

open FormDom

variable [CompleteSpace F]

/-- **The Friedrichs extension theorem (K. Friedrichs 1934; Reed–Simon Vol. II
Thm X.23), proved — not assumed — with no boundedness hypothesis.**

Every densely defined, symmetric, positive operator on a complex Hilbert space
has a positive self-adjoint extension: the Friedrichs extension, constructed
here as `S⁻¹ − 1` for the resolvent `S = (H + 1)⁻¹` obtained by Riesz
representation in the completed form space.

This is the unbounded analogue of
`BookProof.YangMillsFriedrichsLimit.friedrichs_of_bounded`, and it closes plan
item 1 of `CONSOLIDATED_PLAN.md` §11.4. -/
theorem friedrichs_extension_exists (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension P.op A := by
  have hinj : Function.Injective (friedrichsResolvent P) :=
    friedrichsResolvent_injective P hdense
  refine ⟨_, invShiftOperator (friedrichsResolvent P) hinj 1, ?_⟩
  refine invShiftOperator_isPositiveSelfAdjointExtension (friedrichsResolvent P) hinj 1
    (friedrichsResolvent_isSelfAdjoint P) (friedrichsResolvent_pos P) (dom_le_range P) P.op ?_
  intro x
  have hpre : preim (friedrichsResolvent P) ⟨(x : F), dom_le_range P x.2⟩
      = (x : F) + P.op x :=
    preim_eq _ hinj _ (friedrichsResolvent_shift P x)
  rw [invShiftOperator_apply, hpre]
  push_cast
  module

/-- **The named hypothesis of
`BookProof.YangMillsFriedrichs.friedrichs_extension_of_semibounded` is a
theorem.**  Wherever the project carried "Friedrichs" as an explicit hypothesis,
it can now be discharged. -/
theorem friedrichs_hypothesis_holds :
    ∀ (D' : Submodule ℂ F) (H' : D' →ₗ[ℂ] F), Dense (D' : Set F) →
      SymmetricOn D' H' → (∀ x : D', 0 ≤ quadForm H' x) →
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H' A :=
  fun D' H' hdense hsym hpos =>
    friedrichs_extension_exists ⟨D', H', hsym, hpos⟩ hdense

/-- **The Weyl-gauge Yang–Mills Hamiltonian has a Friedrichs extension —
unconditionally.**  `½ Σᵢ πᵢ² + ½ Σₐ Bₐ²` on a dense domain, with symmetric
electric- and magnetic-field operators, has a positive self-adjoint extension.
No boundedness of `πᵢ`, `Bₐ` or of the Hamiltonian is assumed: this is
`BookProof.YangMillsFriedrichs.weyl_friedrichs_extension` with its hypothesis
removed. -/
theorem weyl_friedrichs_extension_unconditional {D : Submodule ℂ F} {n m : ℕ}
    {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hdense : Dense (D : Set F))
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F),
      IsPositiveSelfAdjointExtension (weylOp pi Bf) A :=
  friedrichs_extension_exists
    ⟨D, weylOp pi Bf, weylOpDom_symmetricOn hpi hB, weylOpDom_quadForm_nonneg hpi hB⟩ hdense

/-! ### The classical statement: symmetric and *bounded below* -/

/-- "`A` on the domain `Dom` is a self-adjoint extension of `H` that is bounded
below by `−c`" — the semibounded analogue of
`BookProof.YangMillsFriedrichs.IsPositiveSelfAdjointExtension`, which is the case
`c = 0`. -/
def IsSemiboundedSelfAdjointExtension (c : ℝ) {D Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (A : Dom →ₗ[ℂ] F) : Prop :=
  (∀ x : D, ∃ h : (x : F) ∈ Dom, A ⟨(x : F), h⟩ = H x) ∧ SymmetricOn Dom A ∧
    (∀ y : Dom, -c * ‖(y : F)‖ ^ 2 ≤ quadForm A y) ∧
    (∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)

/-- **The Friedrichs extension theorem in its classical form**: a densely defined
symmetric operator that is *bounded below* — `⟪x, H x⟫ ≥ −c‖x‖²`, not necessarily
positive — has a self-adjoint extension with the same lower bound.  Reduced to
the positive case by the shift `H ↦ H + c`. -/
theorem friedrichs_extension_of_semibounded_below {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D H) (c : ℝ)
    (hbelow : ∀ x : D, -c * ‖(x : F)‖ ^ 2 ≤ quadForm H x) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsSemiboundedSelfAdjointExtension c H A := by
  -- the shifted operator `H + c` is positive
  set Hc : D →ₗ[ℂ] F := H + (c : ℂ) • D.subtype with hHc
  have hshift : ∀ x : D, quadForm Hc x = quadForm H x + c * ‖(x : F)‖ ^ 2 := by
    intro x
    simp only [hHc, quadForm, LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply,
      inner_add_right, inner_smul_right, Complex.add_re]
    congr 1
    rw [inner_self_eq_norm_sq_to_K]
    simp [← Complex.ofReal_pow]
  have hcsym : SymmetricOn D Hc := by
    intro x y
    simp only [hHc, LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply,
      inner_add_left, inner_add_right, inner_smul_left, inner_smul_right, Complex.conj_ofReal]
    rw [hsym x y]
  have hcpos : ∀ x : D, 0 ≤ quadForm Hc x := by
    intro x
    rw [hshift]
    linarith [hbelow x]
  obtain ⟨Dom, A', hA'⟩ := friedrichs_extension_exists ⟨D, Hc, hcsym, hcpos⟩ hdense
  obtain ⟨hagree, hsymA, hposA, hsa⟩ := hA'
  refine ⟨Dom, A' - (c : ℂ) • Dom.subtype, ?_, ?_, ?_, ?_⟩
  · intro x
    obtain ⟨h, hx⟩ := hagree x
    refine ⟨h, ?_⟩
    simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply, hx, hHc,
      LinearMap.add_apply]
    module
  · intro x y
    simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply,
      inner_sub_left, inner_sub_right, inner_smul_left, inner_smul_right, Complex.conj_ofReal]
    rw [hsymA x y]
  · intro y
    have h : quadForm (A' - (c : ℂ) • Dom.subtype) y = quadForm A' y - c * ‖(y : F)‖ ^ 2 := by
      simp only [quadForm, LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply,
        inner_sub_right, inner_smul_right, Complex.sub_re]
      congr 1
      rw [inner_self_eq_norm_sq_to_K]
      simp [← Complex.ofReal_pow]
    rw [h]
    linarith [hposA y]
  · intro w u hw
    have hw' : ∀ v : Dom, (inner ℂ (A' v) w : ℂ) = inner ℂ (v : F) (u + (c : ℂ) • w) := by
      intro v
      have := hw v
      simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply,
        inner_sub_left, inner_smul_left, Complex.conj_ofReal] at this
      rw [inner_add_right, inner_smul_right, ← this]
      ring
    obtain ⟨h, hval⟩ := hsa w (u + (c : ℂ) • w) hw'
    refine ⟨h, ?_⟩
    simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply, hval]
    module

/-! ## Part E — the Hashimoto/SIRK limit selects the constructed extension -/

open Filter Topology

/-- **The unbounded selection theorem, with the extension constructed rather than
assumed.**  For a symmetric positive Hamiltonian given by its matrix in a
complete orthonormal (Hermite/occupation-number) basis — *no boundedness* — the
Friedrichs extension `A` exists, and for every shift `γ > 0` the shift-inverted
operator `R = (A + γ)⁻¹` is bounded and self-adjoint, its Galerkin truncations
converge to it strongly and in the resolvent sense, and `R` determines `A`
uniquely.

Together with `friedrichs_extension_exists` this is the full statement of
`CONSOLIDATED_PLAN.md` §11.4: existence *and* selection, for the unbounded
operator. -/
theorem friedrichs_hashimoto_selects (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn (finiteModeDomain b) H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (R : F →L[ℂ] F),
      IsPositiveSelfAdjointExtension H A ∧ IsShiftInvert A γ R ∧ ‖R‖ ≤ γ⁻¹ ∧
        IsSelfAdjoint R ∧
        (∀ u : F, Tendsto (fun k : ℕ => galerkinCompression R b k u) atTop (nhds (R u))) ∧
        (∀ z : ℂ, z.im ≠ 0 → ∀ u : F,
          Tendsto (fun k : ℕ => resolvent (galerkinCompression R b k) z u) atTop
            (nhds (resolvent R z u))) ∧
        (∀ (Dom' : Submodule ℂ F) (A' : Dom' →ₗ[ℂ] F), IsShiftInvert A' γ R →
          Dom' = Dom ∧ ∀ (x : F) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) := by
  obtain ⟨Dom, A, hA⟩ :=
    friedrichs_extension_exists ⟨finiteModeDomain b, H, hsym, hpos⟩ (finiteModeDomain_dense b)
  obtain ⟨R, hR, hnorm, hsa, -, hstrong, hres, huniq⟩ :=
    hashimoto_shiftInvert_selects_friedrichs b H A hA hγ
  exact ⟨Dom, A, R, hA, hR, hnorm, hsa, hstrong, hres, huniq⟩

/-- **The Weyl-gauge Hamiltonian in the occupation-number realization.**  Plan
item 2 of `CONSOLIDATED_PLAN.md` §11.4 settles the continuum realization in
favour of the occupation-number/Hermite picture: the fields act on the
finite-mode domain of a complete orthonormal basis of the Fock space.  In that
realization the Weyl-gauge Hamiltonian `½ Σ πᵢ² + ½ Σ Bₐ²` — unbounded, with no
boundedness hypothesis — has a Friedrichs extension, and the Hashimoto/SIRK
algorithm selects exactly it. -/
theorem weyl_hashimoto_selects_friedrichs (b : HilbertBasis ℕ ℂ F) {n m : ℕ}
    {pi : Fin n → finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    {Bf : Fin m → finiteModeDomain b →ₗ[ℂ] finiteModeDomain b}
    (hpi : ∀ i, SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn (finiteModeDomain b) ((finiteModeDomain b).subtype.comp (Bf a)))
    {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F) (R : F →L[ℂ] F),
      IsPositiveSelfAdjointExtension (weylOp pi Bf) A ∧ IsShiftInvert A γ R ∧
        IsSelfAdjoint R ∧
        (∀ u : F, Tendsto (fun k : ℕ => galerkinCompression R b k u) atTop (nhds (R u))) ∧
        (∀ (Dom' : Submodule ℂ F) (A' : Dom' →ₗ[ℂ] F), IsShiftInvert A' γ R → Dom' = Dom) := by
  obtain ⟨Dom, A, R, hA, hR, -, hsa, hstrong, -, huniq⟩ :=
    friedrichs_hashimoto_selects b (weylOp pi Bf) (weylOpDom_symmetricOn hpi hB)
      (weylOpDom_quadForm_nonneg hpi hB) hγ
  exact ⟨Dom, A, R, hA, hR, hsa, hstrong, fun Dom' A' hA' => (huniq Dom' A' hA').1⟩

/-! ## Part F — the construction is not vacuous: a genuinely unbounded operator -/

/-- **The construction applied to a genuinely unbounded operator.**  For the
diagonal operator `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)` restricted to the finite-mode
domain — unbounded, by
`BookProof.HashimotoShiftInvert.ell2ExampleMatrix_unbounded` — the Friedrichs
extension is produced by `friedrichs_extension_exists`, with no extension
assumed as input. -/
theorem unbounded_friedrichs_example :
    (∃ (Dom : Submodule ℂ (ℓ²(ℕ, ℂ))) (A : Dom →ₗ[ℂ] ℓ²(ℕ, ℂ)),
        IsPositiveSelfAdjointExtension ell2ExampleMatrix A) ∧
      ∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
        C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖ := by
  obtain ⟨-, hsym, hpos, -⟩ := ell2Example_isPositiveSelfAdjointExtension
  refine ⟨friedrichs_extension_exists
    ⟨finiteModeDomain ell2Basis, ell2ExampleMatrix, ?_, ?_⟩ (finiteModeDomain_dense ell2Basis),
    ell2ExampleMatrix_unbounded⟩
  · intro x y
    exact hsym ⟨(x : ℓ²(ℕ, ℂ)), finiteModeDomain_le_range x.2⟩
      ⟨(y : ℓ²(ℕ, ℂ)), finiteModeDomain_le_range y.2⟩
  · intro x
    exact hpos ⟨(x : ℓ²(ℕ, ℂ)), finiteModeDomain_le_range x.2⟩

end BookProof.FriedrichsExtension
