import BookProof.Prelude
import BookProof.ChapterClosureUniqueness

/-!
# `(A²)_F = A* Ā` — the Friedrichs extension of the square is the factorization

`BookProof.ChapterClosureUniqueness` renders the composite `A* ∘ Ā` of a densely
defined symmetric operator `A` as a relation `factorGraph A ⊆ F × F` and proves
that this relation is uniquely determined by `A` (it does not depend on the
realization of the closure, nor on the core), that it extends `A²`, that it is
symmetric and that its quadratic form is `‖Āx‖² ≥ 0`.  What it left open is the
identity itself:

> the composite `A* Ā` **is** the Friedrichs extension of `A²`.

This module proves it.  `A` is a densely defined symmetric operator whose domain
`D` is invariant (`A D ⊆ D`), so `A²` is a symmetric non-negative operator on the
same domain, and the Friedrichs extension of `A²` is characterized — this is the
Freudenthal/Krein characterization — as the unique **self-adjoint extension of
`A²` whose domain lies in the form domain**.  The form of `A²` is
`⟪x, A²y⟫ = ⟪Ax, Ay⟫`, so the form domain is the domain `clDom A` of the closure
`Ā` (the graph-norm closure of `D` is exactly the closed graph, by definition).

## The statement

`IsFriedrichsSqExtension A hstab R` says that the relation `R ⊆ F × F` is

* an extension of `A²` (`extends_sq`),
* supported in the form domain, `x ∈ clDom A` for every `(x, z) ∈ R`
  (`form_domain`), and
* self-adjoint, `R* = R` (`selfAdjoint`; it is in particular symmetric,
  `IsFriedrichsSqExtension.symmetric`).

**`isFriedrichsSqExtension_iff_eq_factorRel`** — for a Hilbert space `F` and a
symmetric `A` with invariant domain (density of the domain is needed only for the
operator form below, not for the statement about relations), `R` has these three
properties **iff** `R = factorRel A`, the relation `A* Ā`.  In particular the
Friedrichs extension of `A²` exists, is unique, and equals `A* Ā`.

The same statement in operator form is **`eq_frExt_of_isSelfAdjointExtension`**:
the relation `A* Ā` is single-valued (`factorRel_snd_eq_zero_of_fst_eq_zero`),
so it is the graph of an operator `frExt A` on `frDom A ≤ clDom A`, that operator
is a positive self-adjoint extension of `A²` (`isSelfAdjointExtension_frExt`,
`frExt_quadForm_nonneg`), and every self-adjoint extension of `A²` whose domain
lies in the form domain has the domain and the values of `frExt A`.

## The two halves

* **Everything symmetric in the form domain is below `A* Ā`**
  (`le_factorRel_of_symmetric_extension`): if `R` is a symmetric extension of
  `A²` whose domain lies in `clDom A`, then `R ≤ factorRel A`.  This needs no
  self-adjointness and no completeness: for `(x, z) ∈ R` and `v ∈ D`,
  symmetry of `R` gives `⟪z, v⟫ = ⟪x, A²v⟫`, while `(x, Āx) ∈ clGraph A` and the
  symmetry of `A` give `⟪Āx, Av⟫ = ⟪x, A²v⟫`; hence `(Āx, z)` is an adjoint pair.
* **`A* Ā` is self-adjoint** (`adjPairs_factorRel`), which is von Neumann's
  theorem `Ā*Ā = (Ā)*Ā` self-adjoint.  The proof is the standard one: the flip
  `V(x, y) = (−y, x)` is unitary on `F ⊕₂ F`, and
  `adjPairs (clGraph A) = (V (clGraph A))ᗮ`, so the closed graph and its flip
  decompose `F ⊕₂ F` orthogonally; splitting `(0, h)` along that decomposition
  solves `x + A*Āx = h` (`exists_mem_factorRel_add`, surjectivity of `1 + A*Ā`),
  and surjectivity upgrades symmetry to self-adjointness.

Together with `BookProof.ClosureUniqueness.factorGraph_eq_of_isCoreOf_pair` this
says that the Friedrichs extension of `A²` may be computed from any core of `Ā`.
-/

namespace BookProof.FriedrichsSquare

open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

/-! ## The composite `A* Ā` as a submodule of `F × F` -/

/-- The relation `A* ∘ Ā` of `BookProof.ClosureUniqueness.factorGraph`, packaged
as a submodule of `F × F` (it is a linear relation). -/
def factorRel (A : D →ₗ[ℂ] F) : Submodule ℂ (F × F) where
  carrier := factorGraph A
  add_mem' := by
    rintro p q ⟨y, hy, hy'⟩ ⟨z, hz, hz'⟩
    exact ⟨y + z, (clGraph A).add_mem hy hz, (adjGraph A).add_mem hy' hz'⟩
  zero_mem' := ⟨0, (clGraph A).zero_mem, (adjGraph A).zero_mem⟩
  smul_mem' := by
    rintro c p ⟨y, hy, hy'⟩
    exact ⟨c • y, (clGraph A).smul_mem c hy, (adjGraph A).smul_mem c hy'⟩

@[simp] theorem mem_factorRel_iff {A : D →ₗ[ℂ] F} {p : F × F} :
    p ∈ factorRel A ↔ ∃ y, (p.1, y) ∈ clGraph A ∧ (y, p.2) ∈ adjGraph A := Iff.rfl

theorem coe_factorRel (A : D →ₗ[ℂ] F) : (factorRel A : Set (F × F)) = factorGraph A := rfl

/-- The domain of `A* Ā` lies in the form domain `clDom A = D(Ā)`. -/
theorem fst_mem_clDom_of_mem_factorRel {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorRel A) :
    p.1 ∈ clDom A := by
  obtain ⟨y, hy, -⟩ := hp
  exact mem_clDom_iff.2 ⟨y, hy⟩

/-- **`Ā ⊆ A*`** : symmetry of `A` passes to the closed graph. -/
theorem clGraph_le_adjGraph {A : D →ₗ[ℂ] F} (hsym : SymmetricOn D A) :
    clGraph A ≤ adjGraph A := by
  intro p hp
  rw [mem_adjGraph_iff]
  intro v
  have h := clGraph_inner hsym hp v
  have h' := congrArg (starRingEnd ℂ) h
  rw [inner_conj_symm, inner_conj_symm] at h'
  exact h'.symm

/-- The adjoint of a relation is antitone. -/
theorem adjPairs_mono {G H : Submodule ℂ (F × F)} (h : G ≤ H) : adjPairs H ≤ adjPairs G :=
  fun _ hp q hq => hp q (h hq)

/-! ## Surjectivity of `1 + A* Ā` -/

section Complete

variable [CompleteSpace F]

/-- The flip of the closed graph, `V 𝒢(Ā) = {(−Āx, x)}`, inside the Hilbert
direct sum `F ⊕₂ F`. -/
def flipGraph (A : D →ₗ[ℂ] F) : Submodule ℂ (WithLp 2 (F × F)) where
  carrier := {p | ((WithLp.ofLp p).2, -(WithLp.ofLp p).1) ∈ clGraph A}
  add_mem' := by
    intro p q hp hq
    have : ((WithLp.ofLp (p + q)).2, -(WithLp.ofLp (p + q)).1)
        = ((WithLp.ofLp p).2, -(WithLp.ofLp p).1) + ((WithLp.ofLp q).2, -(WithLp.ofLp q).1) := by
      simp [add_comm]
    rw [Set.mem_setOf_eq, this]
    exact (clGraph A).add_mem hp hq
  zero_mem' := by
    have : ((WithLp.ofLp (0 : WithLp 2 (F × F))).2, -(WithLp.ofLp (0 : WithLp 2 (F × F))).1)
        = (0 : F × F) := by simp [Prod.ext_iff]
    rw [Set.mem_setOf_eq, this]
    exact (clGraph A).zero_mem
  smul_mem' := by
    intro c p hp
    have : ((WithLp.ofLp (c • p)).2, -(WithLp.ofLp (c • p)).1)
        = c • ((WithLp.ofLp p).2, -(WithLp.ofLp p).1) := by
      simp [smul_neg]
    rw [Set.mem_setOf_eq, this]
    exact (clGraph A).smul_mem c hp

omit [CompleteSpace F] in
theorem mem_flipGraph_iff {A : D →ₗ[ℂ] F} {p : WithLp 2 (F × F)} :
    p ∈ flipGraph A ↔ ((WithLp.ofLp p).2, -(WithLp.ofLp p).1) ∈ clGraph A := Iff.rfl

omit [CompleteSpace F] in
theorem flipGraph_isClosed (A : D →ₗ[ℂ] F) :
    IsClosed ((flipGraph A : Submodule ℂ (WithLp 2 (F × F))) : Set (WithLp 2 (F × F))) := by
  have hcont : Continuous fun p : WithLp 2 (F × F) => ((WithLp.ofLp p).2, -(WithLp.ofLp p).1) := by
    fun_prop
  exact (clGraph_isClosed A).preimage hcont

instance flipGraph_hasOrthogonalProjection (A : D →ₗ[ℂ] F) :
    (flipGraph A).HasOrthogonalProjection := by
  haveI : CompleteSpace (flipGraph A) := by
    haveI := flipGraph_isClosed A
    exact IsClosed.completeSpace_coe
  exact Submodule.HasOrthogonalProjection.ofCompleteSpace _

omit [CompleteSpace F] in
/-- **The orthogonal complement of the flipped graph is the adjoint.** -/
theorem mem_flipGraph_orthogonal_iff {A : D →ₗ[ℂ] F} {q : WithLp 2 (F × F)} :
    q ∈ (flipGraph A)ᗮ ↔ WithLp.ofLp q ∈ adjGraph A := by
  rw [adjGraph_eq_adjPairs_clGraph, Submodule.mem_orthogonal]
  constructor
  · intro hq r hr
    have hmem : WithLp.toLp 2 (-r.2, r.1) ∈ flipGraph A := by
      rw [mem_flipGraph_iff]
      simpa using hr
    have h0 := hq _ hmem
    rw [WithLp.prod_inner_apply] at h0
    simp only [inner_neg_left] at h0
    linear_combination -h0
  · intro hq u hu
    have hr : ((WithLp.ofLp u).2, -(WithLp.ofLp u).1) ∈ clGraph A := hu
    have h := hq _ hr
    simp only [inner_neg_left] at h
    rw [WithLp.prod_inner_apply]
    linear_combination -h

/-- **`1 + A* Ā` is surjective.** -/
theorem exists_mem_factorRel_add (A : D →ₗ[ℂ] F) (h : F) :
    ∃ p : F × F, p ∈ factorRel A ∧ p.1 + p.2 = h := by
  obtain ⟨k, hk, w, hw, hsum⟩ :=
    Submodule.exists_add_mem_mem_orthogonal (K := flipGraph A) (WithLp.toLp 2 (0, h))
  have hkG : ((WithLp.ofLp k).2, -(WithLp.ofLp k).1) ∈ clGraph A := hk
  have hwadj : WithLp.ofLp w ∈ adjGraph A := mem_flipGraph_orthogonal_iff.1 hw
  have hsum' : (0, h) = WithLp.ofLp k + WithLp.ofLp w := congrArg WithLp.ofLp hsum
  have h1 : (WithLp.ofLp w).1 = -(WithLp.ofLp k).1 := by
    have hh : (WithLp.ofLp k).1 + (WithLp.ofLp w).1 = (0 : F) := by
      simpa using (congrArg Prod.fst hsum').symm
    exact eq_neg_of_add_eq_zero_right hh
  have h2 : (WithLp.ofLp w).2 = h - (WithLp.ofLp k).2 := by
    have hh : (WithLp.ofLp k).2 + (WithLp.ofLp w).2 = h := by
      simpa using (congrArg Prod.snd hsum').symm
    exact eq_sub_of_add_eq' hh
  refine ⟨((WithLp.ofLp k).2, h - (WithLp.ofLp k).2), ⟨-(WithLp.ofLp k).1, hkG, ?_⟩, by simp⟩
  have : ((-(WithLp.ofLp k).1 : F), h - (WithLp.ofLp k).2) = WithLp.ofLp w := by
    rw [Prod.ext_iff]
    exact ⟨h1.symm, h2.symm⟩
  rw [this]
  exact hwadj

end Complete

/-! ## `A* Ā` is symmetric, and self-adjoint -/

/-- `A* Ā` is symmetric: `A* Ā ⊆ (A* Ā)*`. -/
theorem factorRel_le_adjPairs (A : D →ₗ[ℂ] F) : factorRel A ≤ adjPairs (factorRel A) := by
  intro p hp q hq
  exact factorGraph_symmetric hq hp

/-- **`A* Ā` is self-adjoint** (von Neumann). -/
theorem adjPairs_factorRel [CompleteSpace F] (A : D →ₗ[ℂ] F) :
    adjPairs (factorRel A) = factorRel A := by
  refine le_antisymm ?_ (factorRel_le_adjPairs A)
  intro p hp
  obtain ⟨r, hr, hrsum⟩ := exists_mem_factorRel_add A (p.1 + p.2)
  have hr' : r ∈ adjPairs (factorRel A) := factorRel_le_adjPairs A hr
  have hv : p - r ∈ adjPairs (factorRel A) := (adjPairs (factorRel A)).sub_mem hp hr'
  have hvsum : (p - r).1 + (p - r).2 = 0 := by
    have hsplit : (p - r).1 + (p - r).2 = (p.1 + p.2) - (r.1 + r.2) := by
      simp only [Prod.fst_sub, Prod.snd_sub]; abel
    rw [hsplit, hrsum, sub_self]
  have key : ∀ x : F, (inner ℂ x (p - r).1 : ℂ) = 0 := by
    intro x
    obtain ⟨q, hq, hqsum⟩ := exists_mem_factorRel_add A x
    have hqv := hv q hq
    have hzero : (inner ℂ q.1 ((p - r).1 + (p - r).2) : ℂ) = 0 := by rw [hvsum]; simp
    rw [inner_add_right] at hzero
    rw [← hqsum, inner_add_left, hqv]
    linear_combination hzero
  have hv1 : (p - r).1 = 0 := by
    have := key (p - r).1
    exact inner_self_eq_zero.1 this
  have hv2 : (p - r).2 = 0 := by
    have := hvsum
    rw [hv1, zero_add] at this
    exact this
  have hpr : p = r := by
    have h1 : p.1 = r.1 := by
      have := hv1
      simp only [Prod.fst_sub, sub_eq_zero] at this
      exact this
    have h2 : p.2 = r.2 := by
      have := hv2
      simp only [Prod.snd_sub, sub_eq_zero] at this
      exact this
    exact Prod.ext h1 h2
  rw [hpr]
  exact hr

/-! ## The Friedrichs extension of `A²` -/

/-- `R` is **a Friedrichs extension of `A²`**: a self-adjoint extension of `A²`,
as a relation, whose domain lies in the form domain `clDom A = D(Ā)`. -/
structure IsFriedrichsSqExtension (A : D →ₗ[ℂ] F) (hstab : ∀ v : D, (A v : F) ∈ D)
    (R : Submodule ℂ (F × F)) : Prop where
  /-- `R` extends `A²`. -/
  extends_sq : ∀ v : D, ((v : F), sqOp A hstab v) ∈ R
  /-- The domain of `R` lies in the form domain of `A²`. -/
  form_domain : ∀ p ∈ R, p.1 ∈ clDom A
  /-- `R` is self-adjoint. -/
  selfAdjoint : adjPairs R = R

/-- A self-adjoint relation is in particular symmetric. -/
theorem IsFriedrichsSqExtension.symmetric {A : D →ₗ[ℂ] F} {hstab : ∀ v : D, (A v : F) ∈ D}
    {R : Submodule ℂ (F × F)} (h : IsFriedrichsSqExtension A hstab R) :
    ∀ p ∈ R, ∀ q ∈ R, (inner ℂ p.2 q.1 : ℂ) = inner ℂ p.1 q.2 := by
  intro p hp q hq
  have hq' : q ∈ adjPairs R := by rw [h.selfAdjoint]; exact hq
  exact hq' p hp

/-- **Every symmetric extension of `A²` living in the form domain is below
`A* Ā`.**  No completeness and no self-adjointness are used. -/
theorem le_factorRel_of_symmetric_extension {A : D →ₗ[ℂ] F} (hsym : SymmetricOn D A)
    {hstab : ∀ v : D, (A v : F) ∈ D} {R : Submodule ℂ (F × F)}
    (hext : ∀ v : D, ((v : F), sqOp A hstab v) ∈ R)
    (hRsym : ∀ p ∈ R, ∀ q ∈ R, (inner ℂ p.2 q.1 : ℂ) = inner ℂ p.1 q.2)
    (hdom : ∀ p ∈ R, p.1 ∈ clDom A) : R ≤ factorRel A := by
  intro p hp
  obtain ⟨x', hx'⟩ := mem_clDom_iff.1 (hdom p hp)
  refine ⟨x', hx', ?_⟩
  rw [mem_adjGraph_iff]
  intro v
  have h1 : (inner ℂ x' ((A v : F)) : ℂ) = inner ℂ p.1 (sqOp A hstab v) :=
    clGraph_inner hsym hx' ⟨(A v : F), hstab v⟩
  have h2 : (inner ℂ p.2 (v : F) : ℂ) = inner ℂ p.1 (sqOp A hstab v) :=
    hRsym p hp ((v : F), sqOp A hstab v) (hext v)
  have h3 : (inner ℂ x' ((A v : F)) : ℂ) = inner ℂ p.2 (v : F) := by
    rw [h1, h2]
  have h4 := congrArg (starRingEnd ℂ) h3
  rw [inner_conj_symm, inner_conj_symm] at h4
  exact h4

/-- `A* Ā` **is** a Friedrichs extension of `A²`. -/
theorem isFriedrichsSqExtension_factorRel [CompleteSpace F] (A : D →ₗ[ℂ] F)
    (hsym : SymmetricOn D A) (hstab : ∀ v : D, (A v : F) ∈ D) :
    IsFriedrichsSqExtension A hstab (factorRel A) where
  extends_sq v := mem_factorGraph_sqOp A hsym hstab v
  form_domain _ hp := fst_mem_clDom_of_mem_factorRel hp
  selfAdjoint := adjPairs_factorRel A

/-- **`(A²)_F = A* Ā`.**  For a densely defined symmetric operator with invariant
domain on a Hilbert space, a relation is a self-adjoint extension of `A²`
supported in the form domain — i.e. a Friedrichs extension of `A²` — if and only
if it is the composite `A* Ā`.  So the Friedrichs extension of `A²` exists, is
unique, and is the factorization. -/
theorem isFriedrichsSqExtension_iff_eq_factorRel [CompleteSpace F] {A : D →ₗ[ℂ] F}
    (hsym : SymmetricOn D A) {hstab : ∀ v : D, (A v : F) ∈ D} {R : Submodule ℂ (F × F)} :
    IsFriedrichsSqExtension A hstab R ↔ R = factorRel A := by
  constructor
  · intro hR
    have hle : R ≤ factorRel A :=
      le_factorRel_of_symmetric_extension hsym hR.extends_sq hR.symmetric hR.form_domain
    refine le_antisymm hle ?_
    calc factorRel A = adjPairs (factorRel A) := (adjPairs_factorRel A).symm
      _ ≤ adjPairs R := adjPairs_mono hle
      _ = R := hR.selfAdjoint
  · rintro rfl
    exact isFriedrichsSqExtension_factorRel A hsym hstab

/-- The **quadratic form** of the Friedrichs extension of `A²` is `‖Āx‖² ≥ 0`. -/
theorem factorRel_quadForm_nonneg {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorRel A) :
    0 ≤ (inner ℂ p.1 p.2 : ℂ).re ∧ (inner ℂ p.1 p.2 : ℂ).im = 0 :=
  factorGraph_quadForm_nonneg hp

/-- The uniqueness half, stated on its own: any two Friedrichs extensions of `A²`
are equal. -/
theorem friedrichsSqExtension_unique [CompleteSpace F] {A : D →ₗ[ℂ] F}
    (hsym : SymmetricOn D A) {hstab : ∀ v : D, (A v : F) ∈ D} {R₁ R₂ : Submodule ℂ (F × F)}
    (h₁ : IsFriedrichsSqExtension A hstab R₁) (h₂ : IsFriedrichsSqExtension A hstab R₂) :
    R₁ = R₂ :=
  ((isFriedrichsSqExtension_iff_eq_factorRel hsym).1 h₁).trans
    ((isFriedrichsSqExtension_iff_eq_factorRel hsym).1 h₂).symm

/-! ## The same statement for operators

The relation `factorRel A` is single-valued as soon as `A` is densely defined and
symmetric, so it is the graph of an operator `frExt A` on the domain `frDom A`;
that operator is a positive self-adjoint extension of `A²`, and it is the unique
one whose domain lies in the form domain. -/

/-- **`A* Ā` is single-valued**: a densely defined symmetric operator is
closable, and the adjoint of a densely defined operator is an operator. -/
theorem factorRel_snd_eq_zero_of_fst_eq_zero {A : D →ₗ[ℂ] F} (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D A) {z : F} (h : ((0 : F), z) ∈ factorRel A) : z = 0 := by
  obtain ⟨y, hy, hz⟩ := h
  have hy0 : y = 0 := clGraph_snd_eq_zero_of_fst_eq_zero hdense hsym hy
  rw [mem_adjGraph_iff] at hz
  refine Dense.eq_zero_of_inner_right hdense fun v => ?_
  have hv := hz v
  simp only [hy0, inner_zero_right] at hv
  exact hv.symm

/-- The domain of `A* Ā`. -/
def frDom (A : D →ₗ[ℂ] F) : Submodule ℂ F := (factorRel A).map (LinearMap.fst ℂ F F)

theorem mem_frDom_iff {A : D →ₗ[ℂ] F} {x : F} : x ∈ frDom A ↔ ∃ z, (x, z) ∈ factorRel A := by
  constructor
  · rintro ⟨p, hp, rfl⟩
    exact ⟨p.2, hp⟩
  · rintro ⟨z, hz⟩
    exact ⟨(x, z), hz, rfl⟩

/-- The value of `A* Ā` at a point of its domain (chosen; unique by
`frFun_unique`). -/
noncomputable def frFun (A : D →ₗ[ℂ] F) (x : frDom A) : F :=
  Classical.choose (mem_frDom_iff.1 x.2)

theorem frFun_spec (A : D →ₗ[ℂ] F) (x : frDom A) : ((x : F), frFun A x) ∈ factorRel A :=
  Classical.choose_spec (mem_frDom_iff.1 x.2)

theorem frFun_unique {A : D →ₗ[ℂ] F} (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A)
    {x : frDom A} {z : F} (h : ((x : F), z) ∈ factorRel A) : frFun A x = z := by
  have hz : ((0 : F), frFun A x - z) ∈ factorRel A := by
    have := Submodule.sub_mem (factorRel A) (frFun_spec A x) h
    simpa using this
  exact sub_eq_zero.mp (factorRel_snd_eq_zero_of_fst_eq_zero hdense hsym hz)

/-- **The Friedrichs extension of `A²`**, as a linear operator. -/
noncomputable def frExt (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) :
    frDom A →ₗ[ℂ] F where
  toFun := frFun A
  map_add' x y := by
    refine frFun_unique hdense hsym ?_
    have := Submodule.add_mem (factorRel A) (frFun_spec A x) (frFun_spec A y)
    simpa using this
  map_smul' c x := by
    refine frFun_unique hdense hsym ?_
    have := Submodule.smul_mem (factorRel A) c (frFun_spec A x)
    simpa using this

@[simp] theorem frExt_apply (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D A) (x : frDom A) : frExt A hdense hsym x = frFun A x := rfl

/-- The graph of `frExt A` is the relation `A* Ā`. -/
theorem opGraph_frExt (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) :
    opGraph (frExt A hdense hsym) = factorRel A := by
  apply le_antisymm
  · rintro p ⟨x, rfl⟩
    simpa using frFun_spec A x
  · intro p hp
    have hx : p.1 ∈ frDom A := mem_frDom_iff.2 ⟨p.2, by simpa using hp⟩
    refine ⟨⟨p.1, hx⟩, ?_⟩
    have hval : frFun A ⟨p.1, hx⟩ = p.2 := frFun_unique hdense hsym (by simpa using hp)
    simp [hval]

/-- The domain of the Friedrichs extension of `A²` lies in the form domain. -/
theorem frDom_le_clDom (A : D →ₗ[ℂ] F) : frDom A ≤ clDom A := by
  intro x hx
  obtain ⟨z, hz⟩ := mem_frDom_iff.1 hx
  exact fst_mem_clDom_of_mem_factorRel (p := (x, z)) hz

/-- **`frExt A` is a self-adjoint extension of `A²`.** -/
theorem isSelfAdjointExtension_frExt [CompleteSpace F] (A : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) (hstab : ∀ v : D, (A v : F) ∈ D) :
    IsSelfAdjointExtension (sqOp A hstab) (frExt A hdense hsym) := by
  refine ⟨fun v => ?_, fun x y => ?_, fun w u hwu => ?_⟩
  · have hmem : ((v : F), sqOp A hstab v) ∈ factorRel A := mem_factorGraph_sqOp A hsym hstab v
    refine ⟨mem_frDom_iff.2 ⟨_, hmem⟩, ?_⟩
    exact frFun_unique hdense hsym hmem
  · exact factorGraph_symmetric (frFun_spec A x) (frFun_spec A y)
  · have hadj : (w, u) ∈ adjPairs (factorRel A) := by
      intro q hq
      have hq1 : q.1 ∈ frDom A := mem_frDom_iff.2 ⟨q.2, by simpa using hq⟩
      have hval : frFun A ⟨q.1, hq1⟩ = q.2 := frFun_unique hdense hsym (by simpa using hq)
      have := hwu ⟨q.1, hq1⟩
      simpa [hval] using this
    have hmem : (w, u) ∈ factorRel A := by
      rw [← adjPairs_factorRel A]; exact hadj
    exact ⟨mem_frDom_iff.2 ⟨u, hmem⟩, frFun_unique hdense hsym hmem⟩

/-- **`frExt A` is positive**: its quadratic form is `‖Āx‖² ≥ 0`. -/
theorem frExt_quadForm_nonneg (A : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D A) (x : frDom A) :
    0 ≤ (inner ℂ (x : F) (frExt A hdense hsym x) : ℂ).re ∧
      (inner ℂ (x : F) (frExt A hdense hsym x) : ℂ).im = 0 :=
  factorGraph_quadForm_nonneg (p := ((x : F), frFun A x)) (frFun_spec A x)

/-- **`(A²)_F = A* Ā`, in operator form.**  Every self-adjoint extension of `A²`
whose domain lies in the form domain `clDom A = D(Ā)` — i.e. every Friedrichs
extension of `A²` — has the domain and the values of `frExt A`, the operator
`A* Ā`. -/
theorem eq_frExt_of_isSelfAdjointExtension [CompleteSpace F] {A : D →ₗ[ℂ] F}
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D A) {hstab : ∀ v : D, (A v : F) ∈ D}
    {Dom : Submodule ℂ F} {B : Dom →ₗ[ℂ] F} (hB : IsSelfAdjointExtension (sqOp A hstab) B)
    (hdomle : Dom ≤ clDom A) :
    Dom = frDom A ∧ ∀ (x : F) (h₁ : x ∈ Dom) (h₂ : x ∈ frDom A),
      B ⟨x, h₁⟩ = frExt A hdense hsym ⟨x, h₂⟩ := by
  have hspec : IsFriedrichsSqExtension A hstab (opGraph B) := by
    refine ⟨fun v => ?_, fun p hp => ?_, ?_⟩
    · obtain ⟨hv, hval⟩ := hB.1 v
      exact ⟨⟨(v : F), hv⟩, by simp [hval]⟩
    · obtain ⟨x, rfl⟩ := hp
      exact hdomle x.2
    · refine le_antisymm (fun p hp => ?_) (fun p hp q hq => ?_)
      · obtain ⟨hw, hval⟩ := hB.2.2 p.1 p.2 fun v => hp ((v : F), B v) ⟨v, rfl⟩
        exact ⟨⟨p.1, hw⟩, by simp [hval]⟩
      · obtain ⟨x, rfl⟩ := hp
        obtain ⟨y, rfl⟩ := hq
        exact hB.2.1 y x
  have hgraph : opGraph B = opGraph (frExt A hdense hsym) := by
    rw [(isFriedrichsSqExtension_iff_eq_factorRel hsym).1 hspec, opGraph_frExt]
  exact eq_of_opGraph_eq hgraph

end BookProof.FriedrichsSquare
