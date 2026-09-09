import Mathlib
import BookProof.ChapterFriedrichsExtension
import BookProof.ChapterQgHermiteFriedrichs

/-!
# The Friedrichs extension is **canonical**

`BookProof.ChapterFriedrichsExtension` proves the *existence* half of the
Friedrichs theorem: a densely defined positive symmetric operator `H` on a
complex Hilbert space has a positive self-adjoint extension, constructed as
`A_F = S⁻¹ − 1` for the form resolvent `S = (H + 1)⁻¹`
(`friedrichs_extension_exists`).  What that statement does *not* say is *which*
extension it is — and a symmetric operator generally has many.

This module supplies the missing half, the one that makes the Friedrichs
extension **the canonical self-adjoint realization**:

* the construction is packaged as a *named* operator rather than an existential:
  `friedrichsDomain P`, `friedrichsOp P hdense`, with
  `friedrichsOp_isPositiveSelfAdjointExtension` re-proving the existence
  statement for it;
* `formDomain P` — the range of the embedding of the form completion, i.e. the
  *form domain* `Q(H)` — contains the domain of `H` (`dom_le_formDomain`) and the
  Friedrichs domain (`friedrichsDomain_le_formDomain`);
* **`friedrichs_canonical`**: *every* symmetric extension of `H` whose domain is
  contained in the form domain is a restriction of `A_F`.  So `A_F` is the
  largest such extension;
* **`friedrichs_unique_selfAdjoint`**: consequently `A_F` is the **unique**
  self-adjoint extension of `H` with domain inside the form domain — the
  classical characterization of the Friedrichs extension (Reed–Simon Vol. II,
  Thm X.23; Kato, Thm VI.2.11).  Both the domain and the action are pinned down.

The named instance is the one `CONSOLIDATED_PLAN.md` §10.6.1 asks about: the
quantum-gravity one-particle scalaron Hamiltonian `−Δ + V(φ)` on the
Gauss–polynomial (Hermite) core of `L²(ℝ)` has a *canonical* self-adjoint
realization (`qgOneParticleHermite_friedrichs_canonical`,
`qgOneParticleHermite_friedrichs_unique`).

**Honest boundary.**  Uniqueness *among extensions with domain in the form
domain* is not essential self-adjointness: an operator that is not essentially
self-adjoint still has other self-adjoint extensions, whose domains necessarily
leave `Q(H)`.  Nothing here claims otherwise.
-/

namespace BookProof.FriedrichsCanonical

open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-! ## The form domain and the Friedrichs operator, as named objects -/

/-- **The form domain `Q(H)`**: the image in `F` of the completion of `dom H` in
the form norm `‖x‖₁² = ‖x‖² + ⟪x, Hx⟫`.  The embedding is injective
(`formExt_injective`), so this really is a copy of the form completion inside
`F`. -/
def formDomain (P : PosSymOp F) : Submodule ℂ F :=
  LinearMap.range (formExt P : FormSpace P →ₗ[ℂ] F)

theorem mem_formDomain {P : PosSymOp F} {v : F} (k : FormSpace P) (hk : formExt P k = v) :
    v ∈ formDomain P := ⟨k, hk⟩

theorem exists_formExt_eq {P : PosSymOp F} {v : F} (hv : v ∈ formDomain P) :
    ∃ k : FormSpace P, formExt P k = v := hv

/-- The operator domain sits inside the form domain. -/
theorem dom_le_formDomain (P : PosSymOp F) : P.dom ≤ formDomain P := by
  intro v hv
  refine ⟨((show FormDom P from ⟨v, hv⟩ : FormDom P) : FormSpace P), ?_⟩
  simp only [ContinuousLinearMap.coe_coe]
  rw [formExt_coe]
  rfl

/-- **The domain of the Friedrichs extension**: the range of the form resolvent
`S = (H + 1)⁻¹`. -/
def friedrichsDomain (P : PosSymOp F) : Submodule ℂ F :=
  LinearMap.range (friedrichsResolvent P : F →ₗ[ℂ] F)

theorem resolvent_mem_friedrichsDomain (P : PosSymOp F) (u : F) :
    friedrichsResolvent P u ∈ friedrichsDomain P := ⟨u, rfl⟩

/-- The Friedrichs domain sits inside the form domain: this is the defining
property that makes the extension canonical. -/
theorem friedrichsDomain_le_formDomain (P : PosSymOp F) :
    friedrichsDomain P ≤ formDomain P := by
  rintro _ ⟨u, rfl⟩
  exact ⟨formRiesz P u, rfl⟩

/-- **The Friedrichs extension of `P`**, as a named operator: `A_F = S⁻¹ − 1`. -/
def friedrichsOp (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    friedrichsDomain P →ₗ[ℂ] F :=
  invShiftOperator (friedrichsResolvent P) (friedrichsResolvent_injective P hdense) 1

theorem friedrichsOp_apply (P : PosSymOp F) (hdense : Dense (P.dom : Set F))
    (y : friedrichsDomain P) :
    friedrichsOp P hdense y
      = preim (friedrichsResolvent P) y - ((1 : ℝ) : ℂ) • (y : F) := rfl

/-- `A_F (S u) = u − S u`: the extension inverts the shifted resolvent. -/
theorem friedrichsOp_resolvent (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) (u : F) :
    friedrichsOp P hdense ⟨friedrichsResolvent P u, resolvent_mem_friedrichsDomain P u⟩
      = u - friedrichsResolvent P u := by
  have hpre : preim (friedrichsResolvent P)
      ⟨friedrichsResolvent P u, resolvent_mem_friedrichsDomain P u⟩ = u :=
    preim_eq _ (friedrichsResolvent_injective P hdense) _ rfl
  rw [friedrichsOp_apply, hpre]
  push_cast
  module

/-- **The named Friedrichs operator is a positive self-adjoint extension of
`H`** — the existence theorem `friedrichs_extension_exists`, restated for the
explicit construction rather than existentially. -/
theorem friedrichsOp_isPositiveSelfAdjointExtension (P : PosSymOp F)
    (hdense : Dense (P.dom : Set F)) :
    IsPositiveSelfAdjointExtension P.op (friedrichsOp P hdense) := by
  refine invShiftOperator_isPositiveSelfAdjointExtension (friedrichsResolvent P)
    (friedrichsResolvent_injective P hdense) 1 (friedrichsResolvent_isSelfAdjoint P)
    (friedrichsResolvent_pos P) (dom_le_range P) P.op ?_
  intro x
  have hpre : preim (friedrichsResolvent P) ⟨(x : F), dom_le_range P x.2⟩
      = (x : F) + P.op x :=
    preim_eq _ (friedrichsResolvent_injective P hdense) _ (friedrichsResolvent_shift P x)
  rw [invShiftOperator_apply, hpre]
  push_cast
  module

theorem friedrichsOp_symmetricOn (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    SymmetricOn (friedrichsDomain P) (friedrichsOp P hdense) :=
  (friedrichsOp_isPositiveSelfAdjointExtension P hdense).2.1

/-! ## The vanishing criterion in the form space -/

omit [CompleteSpace F] in
/-- A vector of the form completion that is form-orthogonal to the whole domain
is zero (the domain is dense in the completion). -/
theorem eq_zero_of_inner_coe_eq_zero (P : PosSymOp F) (k : FormSpace P)
    (h : ∀ v : FormDom P, (inner ℂ (v : FormSpace P) k : ℂ) = 0) : k = 0 := by
  have hall : ∀ z : FormSpace P, (inner ℂ z k : ℂ) = 0 := by
    intro z
    refine UniformSpace.Completion.induction_on z ?_ h
    exact isClosed_eq (by fun_prop) (by fun_prop)
  simpa using hall k

/-! ## Canonicity -/

/-- **The Friedrichs extension dominates every symmetric extension living in the
form domain.**  If `A'` is a symmetric extension of `H` whose domain is contained
in the form domain `Q(H)`, then every vector of `Dom A'` lies in the Friedrichs
domain and `A'` agrees there with `A_F`.

This is the canonicity statement: among all symmetric extensions with domain
inside the form domain, `A_F` is the largest. -/
theorem friedrichs_canonical (P : PosSymOp F) (hdense : Dense (P.dom : Set F))
    {Dom' : Submodule ℂ F} (A' : Dom' →ₗ[ℂ] F)
    (hext : ∀ x : P.dom, ∃ h : (x : F) ∈ Dom', A' ⟨(x : F), h⟩ = P.op x)
    (hsym : SymmetricOn Dom' A') (hform : Dom' ≤ formDomain P)
    (x : F) (hx : x ∈ Dom') :
    ∃ h : x ∈ friedrichsDomain P, friedrichsOp P hdense ⟨x, h⟩ = A' ⟨x, hx⟩ := by
  obtain ⟨u, hu⟩ : ∃ u : F, u = A' ⟨x, hx⟩ + x := ⟨_, rfl⟩
  -- the difference `x − S u` lies in the form domain, so it is `formExt k`
  obtain ⟨k₁, hk₁⟩ := exists_formExt_eq (hform hx)
  have hkval : formExt P (k₁ - formRiesz P u) = x - friedrichsResolvent P u := by
    rw [map_sub, hk₁, friedrichsResolvent_apply]
  -- `k` is form-orthogonal to the domain
  have hzero : ∀ v : FormDom P,
      (inner ℂ (v : FormSpace P) (k₁ - formRiesz P u) : ℂ) = 0 := by
    intro v
    rw [inner_coe_eq, hkval, inner_sub_right]
    -- pairing with `x`
    have hxpair : (inner ℂ (toAmbient v + P.op (toDom v)) x : ℂ)
        = inner ℂ (toAmbient v) u := by
      obtain ⟨hmem, hval⟩ := hext (toDom v)
      have hsy : (inner ℂ (A' ⟨((toDom v : P.dom) : F), hmem⟩) x : ℂ)
          = inner ℂ ((toDom v : P.dom) : F) (A' ⟨x, hx⟩) := hsym ⟨_, hmem⟩ ⟨x, hx⟩
      rw [hval] at hsy
      rw [toAmbient_eq, inner_add_left, hsy, hu, inner_add_right]
      ring
    -- pairing with `S u`
    have hypair : (inner ℂ (toAmbient v + P.op (toDom v)) (friedrichsResolvent P u) : ℂ)
        = inner ℂ (toAmbient v) u := by
      have hsa := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp
        (friedrichsResolvent_isSelfAdjoint P)
      rw [toAmbient_eq]
      have h1 : (inner ℂ (((toDom v : P.dom) : F) + P.op (toDom v))
            (friedrichsResolvent P u) : ℂ)
          = inner ℂ (friedrichsResolvent P (((toDom v : P.dom) : F) + P.op (toDom v))) u :=
        (hsa (((toDom v : P.dom) : F) + P.op (toDom v)) u).symm
      rw [h1, friedrichsResolvent_shift P (toDom v)]
    rw [hxpair, hypair, sub_self]
  have hk0 : k₁ - formRiesz P u = 0 := eq_zero_of_inner_coe_eq_zero P _ hzero
  have hxy : x = friedrichsResolvent P u := by
    have h0 : x - friedrichsResolvent P u = 0 := by rw [← hkval, hk0, map_zero]
    exact sub_eq_zero.mp h0
  have hmem : x ∈ friedrichsDomain P := by
    rw [hxy]; exact resolvent_mem_friedrichsDomain P u
  refine ⟨hmem, ?_⟩
  have hcongr : (⟨x, hmem⟩ : friedrichsDomain P)
      = ⟨friedrichsResolvent P u, resolvent_mem_friedrichsDomain P u⟩ := Subtype.ext hxy
  rw [hcongr, friedrichsOp_resolvent, ← hxy, hu]
  module

/-- **Uniqueness: the Friedrichs extension is *the* self-adjoint extension whose
domain lies in the form domain.**  If `A'` is a positive self-adjoint extension
of `H` with `Dom A' ⊆ Q(H)`, then `Dom A' = Dom A_F` and `A' = A_F`.

Together with `friedrichsOp_isPositiveSelfAdjointExtension` this is the
Friedrichs theorem in its canonical form (Reed–Simon Vol. II, Thm X.23). -/
theorem friedrichs_unique_selfAdjoint (P : PosSymOp F) (hdense : Dense (P.dom : Set F))
    {Dom' : Submodule ℂ F} (A' : Dom' →ₗ[ℂ] F)
    (hA' : IsPositiveSelfAdjointExtension P.op A') (hform : Dom' ≤ formDomain P) :
    Dom' = friedrichsDomain P ∧
      ∀ (x : F) (hx : x ∈ Dom') (hx' : x ∈ friedrichsDomain P),
        A' ⟨x, hx⟩ = friedrichsOp P hdense ⟨x, hx'⟩ := by
  obtain ⟨hext, hsym, -, hcrit⟩ := hA'
  have hsub : ∀ (x : F) (hx : x ∈ Dom'), ∃ h : x ∈ friedrichsDomain P,
      friedrichsOp P hdense ⟨x, h⟩ = A' ⟨x, hx⟩ :=
    fun x hx => friedrichs_canonical P hdense A' hext hsym hform x hx
  have hle : Dom' ≤ friedrichsDomain P := fun x hx => (hsub x hx).choose
  have hagree : ∀ (x : F) (hx : x ∈ Dom') (hx' : x ∈ friedrichsDomain P),
      A' ⟨x, hx⟩ = friedrichsOp P hdense ⟨x, hx'⟩ := by
    intro x hx hx'
    exact ((hsub x hx).choose_spec).symm
  refine ⟨le_antisymm hle ?_, hagree⟩
  -- the converse inclusion: a self-adjoint operator has no proper symmetric extension
  intro w hw
  have hpair : ∀ v : Dom', (inner ℂ (A' v) w : ℂ)
      = inner ℂ (v : F) (friedrichsOp P hdense ⟨w, hw⟩) := by
    intro v
    have hv' : (v : F) ∈ friedrichsDomain P := hle v.2
    have h1 : (A' v : F) = friedrichsOp P hdense ⟨(v : F), hv'⟩ := by
      have := hagree (v : F) v.2 hv'
      simpa using this
    rw [h1]
    exact friedrichsOp_symmetricOn P hdense ⟨(v : F), hv'⟩ ⟨w, hw⟩
  exact (hcrit w (friedrichsOp P hdense ⟨w, hw⟩) hpair).choose

/-! ## The classical (merely semibounded) statement -/

section Semibounded

variable {D : Submodule ℂ F}

omit [CompleteSpace F] in
/-- Shifting an operator by a real constant shifts its quadratic form. -/
theorem quadForm_shift (H : D →ₗ[ℂ] F) (c : ℝ) (x : D) :
    quadForm (H + (c : ℂ) • D.subtype) x = quadForm H x + c * ‖(x : F)‖ ^ 2 := by
  simp only [quadForm, LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply,
    inner_add_right, inner_smul_right, Complex.add_re]
  congr 1
  rw [inner_self_eq_norm_sq_to_K]
  simp [← Complex.ofReal_pow]

omit [CompleteSpace F] in
theorem symmetricOn_shift {H : D →ₗ[ℂ] F} (hsym : SymmetricOn D H) (c : ℝ) :
    SymmetricOn D (H + (c : ℂ) • D.subtype) := by
  intro x y
  simp only [LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply,
    inner_add_left, inner_add_right, inner_smul_left, inner_smul_right, Complex.conj_ofReal]
  rw [hsym x y]

/-- **The shift `H + c` of a symmetric operator bounded below by `−c`**, as a
positive symmetric operator: the object the Friedrichs machinery consumes. -/
def shiftedPosSymOp (H : D →ₗ[ℂ] F) (hsym : SymmetricOn D H) (c : ℝ)
    (hbelow : ∀ x : D, -c * ‖(x : F)‖ ^ 2 ≤ quadForm H x) : PosSymOp F where
  dom := D
  op := H + (c : ℂ) • D.subtype
  sym := symmetricOn_shift hsym c
  pos := by
    intro x
    rw [quadForm_shift]
    linarith [hbelow x]

omit [CompleteSpace F] in
/-- Un-shifting a positive self-adjoint extension of `H + c` gives a
self-adjoint extension of `H` bounded below by `−c`. -/
theorem isSemibounded_of_isPositive_shift {Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (c : ℝ)
    (A : Dom →ₗ[ℂ] F)
    (hA : IsPositiveSelfAdjointExtension (H + (c : ℂ) • D.subtype) A) :
    IsSemiboundedSelfAdjointExtension c H (A - (c : ℂ) • Dom.subtype) := by
  obtain ⟨hagree, hsymA, hposA, hsa⟩ := hA
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro x
    obtain ⟨h, hx⟩ := hagree x
    refine ⟨h, ?_⟩
    simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply, hx,
      LinearMap.add_apply]
    module
  · intro x y
    simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply,
      inner_sub_left, inner_sub_right, inner_smul_left, inner_smul_right, Complex.conj_ofReal]
    rw [hsymA x y]
  · intro y
    have h : quadForm (A - (c : ℂ) • Dom.subtype) y = quadForm A y - c * ‖(y : F)‖ ^ 2 := by
      have h1 := quadForm_shift A (-c) y
      simp only [Complex.ofReal_neg, neg_smul, neg_mul, ← sub_eq_add_neg] at h1
      exact h1
    rw [h]
    linarith [hposA y]
  · intro w u hw
    have hw' : ∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) (u + (c : ℂ) • w) := by
      intro v
      have hv := hw v
      simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply,
        inner_sub_left, inner_smul_left, Complex.conj_ofReal] at hv
      rw [inner_add_right, inner_smul_right, ← hv]
      ring
    obtain ⟨h, hval⟩ := hsa w (u + (c : ℂ) • w) hw'
    refine ⟨h, ?_⟩
    simp only [LinearMap.sub_apply, LinearMap.smul_apply, Submodule.subtype_apply, hval]
    module

omit [CompleteSpace F] in
/-- Conversely, shifting a semibounded self-adjoint extension of `H` gives a
positive self-adjoint extension of `H + c`. -/
theorem isPositive_shift_of_isSemibounded {Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (c : ℝ)
    (A : Dom →ₗ[ℂ] F) (hA : IsSemiboundedSelfAdjointExtension c H A) :
    IsPositiveSelfAdjointExtension (H + (c : ℂ) • D.subtype) (A + (c : ℂ) • Dom.subtype) := by
  obtain ⟨hagree, hsymA, hbelowA, hsa⟩ := hA
  refine ⟨?_, ?_, ?_, ?_⟩
  · intro x
    obtain ⟨h, hx⟩ := hagree x
    refine ⟨h, ?_⟩
    simp only [LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply, hx]
  · intro x y
    simp only [LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply,
      inner_add_left, inner_add_right, inner_smul_left, inner_smul_right, Complex.conj_ofReal]
    rw [hsymA x y]
  · intro y
    rw [quadForm_shift]
    linarith [hbelowA y]
  · intro w u hw
    have hw' : ∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) (u - (c : ℂ) • w) := by
      intro v
      have hv := hw v
      simp only [LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply,
        inner_add_left, inner_smul_left, Complex.conj_ofReal] at hv
      rw [inner_sub_right, inner_smul_right, ← hv]
      ring
    obtain ⟨h, hval⟩ := hsa w (u - (c : ℂ) • w) hw'
    refine ⟨h, ?_⟩
    simp only [LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply, hval]
    module

/-- **The Friedrichs extension of a merely semibounded symmetric operator**:
`A_F − c`, for the Friedrichs extension of the positive shift `H + c`. -/
def semiboundedFriedrichsOp (H : D →ₗ[ℂ] F) (hsym : SymmetricOn D H) (c : ℝ)
    (hbelow : ∀ x : D, -c * ‖(x : F)‖ ^ 2 ≤ quadForm H x) (hdense : Dense (D : Set F)) :
    friedrichsDomain (shiftedPosSymOp H hsym c hbelow) →ₗ[ℂ] F :=
  friedrichsOp (shiftedPosSymOp H hsym c hbelow) hdense
    - (c : ℂ) • (friedrichsDomain (shiftedPosSymOp H hsym c hbelow)).subtype

/-- **The Friedrichs extension theorem, classical form**: a densely defined
symmetric operator bounded below by `−c` has a self-adjoint extension with the
same lower bound — here the explicitly constructed one. -/
theorem semiboundedFriedrichsOp_isSemiboundedSelfAdjointExtension (H : D →ₗ[ℂ] F)
    (hsym : SymmetricOn D H) (c : ℝ)
    (hbelow : ∀ x : D, -c * ‖(x : F)‖ ^ 2 ≤ quadForm H x) (hdense : Dense (D : Set F)) :
    IsSemiboundedSelfAdjointExtension c H (semiboundedFriedrichsOp H hsym c hbelow hdense) :=
  isSemibounded_of_isPositive_shift H c _
    (friedrichsOp_isPositiveSelfAdjointExtension (shiftedPosSymOp H hsym c hbelow) hdense)

/-- **Canonicity in the semibounded case**: the constructed extension is the
unique self-adjoint extension of `H`, bounded below by `−c`, whose domain lies
inside the form domain of the positive shift `H + c`. -/
theorem semibounded_friedrichs_unique (H : D →ₗ[ℂ] F) (hsym : SymmetricOn D H) (c : ℝ)
    (hbelow : ∀ x : D, -c * ‖(x : F)‖ ^ 2 ≤ quadForm H x) (hdense : Dense (D : Set F))
    {Dom' : Submodule ℂ F} (A' : Dom' →ₗ[ℂ] F)
    (hA' : IsSemiboundedSelfAdjointExtension c H A')
    (hform : Dom' ≤ formDomain (shiftedPosSymOp H hsym c hbelow)) :
    Dom' = friedrichsDomain (shiftedPosSymOp H hsym c hbelow) ∧
      ∀ (x : F) (hx : x ∈ Dom')
        (hx' : x ∈ friedrichsDomain (shiftedPosSymOp H hsym c hbelow)),
        A' ⟨x, hx⟩ = semiboundedFriedrichsOp H hsym c hbelow hdense ⟨x, hx'⟩ := by
  obtain ⟨hdom, hval⟩ := friedrichs_unique_selfAdjoint (shiftedPosSymOp H hsym c hbelow) hdense
    (A' + (c : ℂ) • Dom'.subtype) (isPositive_shift_of_isSemibounded H c A' hA') hform
  refine ⟨hdom, ?_⟩
  intro x hx hx'
  have h := hval x hx hx'
  simp only [LinearMap.add_apply, LinearMap.smul_apply, Submodule.subtype_apply] at h
  simp only [semiboundedFriedrichsOp, LinearMap.sub_apply, LinearMap.smul_apply,
    Submodule.subtype_apply, ← h]
  module

end Semibounded

end

/-! ## The quantum-gravity instance -/

section QG

open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs BookProof.HermiteProductCore

noncomputable section

/-- The scalaron Hamiltonian on the Gauss–polynomial (Hermite) core, bundled as a
positive symmetric operator. -/
def qgScalaronPosSymOp (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) :
    PosSymOp (L2d 1) where
  dom := polyGaussCore
  op := hamCore (scalaronW M alpha) (continuous_scalaronW M alpha) (expBounded_scalaronW M alpha hM)
  sym := hamCore_symmetricOn _ _ _
  pos := hamCore_quadForm_nonneg _ _ _ (scalaronW_nonneg halpha)

theorem qgScalaronPosSymOp_dense (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) :
    Dense (((qgScalaronPosSymOp M alpha hM halpha).dom : Submodule ℂ (L2d 1)) : Set (L2d 1)) :=
  polyGaussCore_dense

/-- **The quantum-gravity one-particle scalaron Hamiltonian has a canonical
self-adjoint realization on the Hermite core**: the Friedrichs operator is a
positive self-adjoint extension of `−Δ + V(φ)`, and it is the *only* one whose
domain is contained in the form domain. -/
theorem qgOneParticleHermite_friedrichs_canonical (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha) :
    IsPositiveSelfAdjointExtension
      (hamCore (scalaronW M alpha) (continuous_scalaronW M alpha) (expBounded_scalaronW M alpha hM))
      (friedrichsOp (qgScalaronPosSymOp M alpha hM halpha)
        (qgScalaronPosSymOp_dense M alpha hM halpha)) :=
  friedrichsOp_isPositiveSelfAdjointExtension (qgScalaronPosSymOp M alpha hM halpha)
    (qgScalaronPosSymOp_dense M alpha hM halpha)

/-- **Uniqueness for the scalaron Hamiltonian**: any positive self-adjoint
extension of `−Δ + V(φ)` from the Gauss–polynomial core whose domain lies inside
the form domain is the Friedrichs one, domain and action alike. -/
theorem qgOneParticleHermite_friedrichs_unique (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha)
    {Dom' : Submodule ℂ (L2d 1)} (A' : Dom' →ₗ[ℂ] L2d 1)
    (hA' : IsPositiveSelfAdjointExtension
      (hamCore (scalaronW M alpha) (continuous_scalaronW M alpha) (expBounded_scalaronW M alpha hM))
      A')
    (hform : Dom' ≤ formDomain (qgScalaronPosSymOp M alpha hM halpha)) :
    Dom' = friedrichsDomain (qgScalaronPosSymOp M alpha hM halpha) ∧
      ∀ (x : L2d 1) (hx : x ∈ Dom')
        (hx' : x ∈ friedrichsDomain (qgScalaronPosSymOp M alpha hM halpha)),
        A' ⟨x, hx⟩ = friedrichsOp (qgScalaronPosSymOp M alpha hM halpha)
          (qgScalaronPosSymOp_dense M alpha hM halpha) ⟨x, hx'⟩ :=
  friedrichs_unique_selfAdjoint (qgScalaronPosSymOp M alpha hM halpha)
    (qgScalaronPosSymOp_dense M alpha hM halpha) A' hA' hform

/-! ### The reduced two-variable sector `(R_c, φ)` -/

/-- The lower bound of the reduced-sector potential: the conformal-mode
polynomial supplies `−c` and the scalaron part is nonnegative. -/
theorem scalaronSectorPotential_lower (M alpha : ℝ) (halpha : 0 < alpha) (V3 : Polynomial ℝ)
    (c : ℝ) (hV3 : ∀ t : ℝ, -c ≤ V3.eval t) (x : Vd 2) :
    -c ≤ scalaronSectorPotential M alpha V3 x := by
  have h1 := hV3 (x 0)
  have h2 := BookProof.Starobinsky.starobinskyV_nonneg (M := M) halpha (x 1)
  simp only [scalaronSectorPotential]
  linarith

/-- The reduced `(R_c, φ)` sector Hamiltonian on the Hermite core, shifted by its
lower bound so as to be positive. -/
def qgSectorShiftedPosSymOp (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha)
    (V3 : Polynomial ℝ) (c : ℝ) (hV3 : ∀ t : ℝ, -c ≤ V3.eval t) : PosSymOp (L2d 2) :=
  shiftedPosSymOp
    (hamCore (scalaronSectorPotential M alpha V3) (continuous_scalaronSectorPotential M alpha V3)
      (expBounded_scalaronSectorPotential M alpha hM V3))
    (hamCore_symmetricOn _ _ _) c
    (hamCore_quadForm_ge _ _ _ c (scalaronSectorPotential_lower M alpha halpha V3 c hV3))

/-- The Friedrichs realization of the reduced-sector Hamiltonian. -/
def qgSectorFriedrichsOp (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha)
    (V3 : Polynomial ℝ) (c : ℝ) (hV3 : ∀ t : ℝ, -c ≤ V3.eval t) :
    friedrichsDomain (qgSectorShiftedPosSymOp M alpha hM halpha V3 c hV3) →ₗ[ℂ] L2d 2 :=
  semiboundedFriedrichsOp
    (hamCore (scalaronSectorPotential M alpha V3) (continuous_scalaronSectorPotential M alpha V3)
      (expBounded_scalaronSectorPotential M alpha hM V3))
    (hamCore_symmetricOn _ _ _) c
    (hamCore_quadForm_ge _ _ _ c (scalaronSectorPotential_lower M alpha halpha V3 c hV3))
    polyGaussCore_dense

/-- **The reduced `(R_c, φ)` sector has a canonical semibounded self-adjoint
realization** on the Gauss–polynomial core of `L²(ℝ²)`, with the lower bound of
its potential. -/
theorem qgOneParticleSector_friedrichs_canonical (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha)
    (V3 : Polynomial ℝ) (c : ℝ) (hV3 : ∀ t : ℝ, -c ≤ V3.eval t) :
    IsSemiboundedSelfAdjointExtension c
      (hamCore (scalaronSectorPotential M alpha V3)
        (continuous_scalaronSectorPotential M alpha V3)
        (expBounded_scalaronSectorPotential M alpha hM V3))
      (qgSectorFriedrichsOp M alpha hM halpha V3 c hV3) :=
  semiboundedFriedrichsOp_isSemiboundedSelfAdjointExtension _ (hamCore_symmetricOn _ _ _) c
    (hamCore_quadForm_ge _ _ _ c (scalaronSectorPotential_lower M alpha halpha V3 c hV3))
    polyGaussCore_dense

/-- **Uniqueness for the reduced sector**: among the self-adjoint extensions with
lower bound `−c` whose domain lies inside the form domain of the positive shift,
the Friedrichs realization is the only one. -/
theorem qgOneParticleSector_friedrichs_unique (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha)
    (V3 : Polynomial ℝ) (c : ℝ) (hV3 : ∀ t : ℝ, -c ≤ V3.eval t)
    {Dom' : Submodule ℂ (L2d 2)} (A' : Dom' →ₗ[ℂ] L2d 2)
    (hA' : IsSemiboundedSelfAdjointExtension c
      (hamCore (scalaronSectorPotential M alpha V3)
        (continuous_scalaronSectorPotential M alpha V3)
        (expBounded_scalaronSectorPotential M alpha hM V3)) A')
    (hform : Dom' ≤ formDomain (qgSectorShiftedPosSymOp M alpha hM halpha V3 c hV3)) :
    Dom' = friedrichsDomain (qgSectorShiftedPosSymOp M alpha hM halpha V3 c hV3) ∧
      ∀ (x : L2d 2) (hx : x ∈ Dom')
        (hx' : x ∈ friedrichsDomain (qgSectorShiftedPosSymOp M alpha hM halpha V3 c hV3)),
        A' ⟨x, hx⟩ = qgSectorFriedrichsOp M alpha hM halpha V3 c hV3 ⟨x, hx'⟩ :=
  semibounded_friedrichs_unique _ (hamCore_symmetricOn _ _ _) c
    (hamCore_quadForm_ge _ _ _ c (scalaronSectorPotential_lower M alpha halpha V3 c hV3))
    polyGaussCore_dense A' hA' hform

end

end QG

/-! ## The canonicity theorem is not vacuous -/

noncomputable section Example

open BookProof.HermiteGalerkin

/-- The genuinely unbounded diagonal operator `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)`, on the
finite-mode domain, as a positive symmetric operator. -/
def ell2ExamplePosSymOp : PosSymOp (ℓ²(ℕ, ℂ)) where
  dom := finiteModeDomain ell2Basis
  op := ell2ExampleMatrix
  sym := by
    obtain ⟨-, hsym, -, -⟩ := ell2Example_isPositiveSelfAdjointExtension
    intro x y
    exact hsym ⟨(x : ℓ²(ℕ, ℂ)), finiteModeDomain_le_range x.2⟩
      ⟨(y : ℓ²(ℕ, ℂ)), finiteModeDomain_le_range y.2⟩
  pos := by
    obtain ⟨-, -, hpos, -⟩ := ell2Example_isPositiveSelfAdjointExtension
    intro x
    exact hpos ⟨(x : ℓ²(ℕ, ℂ)), finiteModeDomain_le_range x.2⟩

/-- **Canonicity applied to a genuinely unbounded operator.**  For `A eₙ = n eₙ`
on the finite-mode domain of `ℓ²(ℕ, ℂ)` — unbounded, by
`BookProof.HashimotoShiftInvert.ell2ExampleMatrix_unbounded` — the Friedrichs
extension is a positive self-adjoint extension and is the only one whose domain
lies inside the form domain.  So neither the construction nor its uniqueness
statement is vacuous. -/
theorem unbounded_friedrichs_canonical_example :
    IsPositiveSelfAdjointExtension ell2ExampleMatrix
        (friedrichsOp ell2ExamplePosSymOp (finiteModeDomain_dense ell2Basis)) ∧
      (∀ (Dom' : Submodule ℂ (ℓ²(ℕ, ℂ))) (A' : Dom' →ₗ[ℂ] ℓ²(ℕ, ℂ)),
          IsPositiveSelfAdjointExtension ell2ExampleMatrix A' →
          Dom' ≤ formDomain ell2ExamplePosSymOp →
          Dom' = friedrichsDomain ell2ExamplePosSymOp) ∧
      ∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
        C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖ :=
  ⟨friedrichsOp_isPositiveSelfAdjointExtension ell2ExamplePosSymOp
      (finiteModeDomain_dense ell2Basis),
    fun _ A' hA' hform =>
      (friedrichs_unique_selfAdjoint ell2ExamplePosSymOp (finiteModeDomain_dense ell2Basis)
        A' hA' hform).1,
    ell2ExampleMatrix_unbounded⟩

end Example

end BookProof.FriedrichsCanonical
