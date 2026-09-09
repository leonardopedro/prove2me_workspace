import BookProof.Prelude
import BookProof.ChapterEsaClosureCore

/-!
# Uniqueness of the closure, and of the `A* ∘ Ā` factorization

`BookProof.ChapterEsaClosure` builds the closure `clExt T` of a densely defined
symmetric operator `T` as the operator whose graph is the topological closure
`clGraph T` of the graph of `T`, and shows that when `T` is essentially
self-adjoint that closure is the unique self-adjoint extension.  This module
answers the two questions that the *applications* of the Faris–Lavine criterion
(`BookProof.ChapterFarisLavine`) raise about that construction.

## 1.  Is the closure unique?

Yes, and this is a purely geometric fact: the closure is *defined* by
`𝒢(Ā) = closure 𝒢(A)`, and the topological closure of a set is unique.  Here:

* `IsClosedExtension T A` — `A` extends `T` and has a closed graph;
* `IsClosureOf T A` — `A` is a *minimal* closed extension of `T`;
* `clGraph_le_opGraph_of_isClosedExtension` — the closed graph of *any* closed
  extension contains `clGraph T`, so a minimal closed extension is exactly one
  whose graph **is** `clGraph T` (`opGraph_eq_clGraph_of_isClosureOf`);
* `clExt_isClosureOf` — the construction of `ChapterEsaClosure` is one;
* **`closure_unique`** — any two closures of `T` have the same domain and the
  same values.  So `Ā` is strictly unique.

## 2.  Closure versus self-adjoint extension

The closure is unique, but it need not be self-adjoint, and self-adjoint
extensions need not be unique.  The first half of that distinction is proved:

* **`not_isSelfAdjointExtension_clExt_of_deficiency`** — if `T` has a non-zero
  deficiency vector at `i`, its (unique) closure is *not* a self-adjoint
  extension.  So "unique closure" is strictly weaker than "unique self-adjoint
  extension"; the latter is the essential-self-adjointness statement
  `BookProof.EsaClosure.isSelfAdjointExtension_unique_of_esa`.

## 3.  The factorization `(A²)_F = A* Ā = Ā* Ā`

The factors are uniquely determined by `A`, and only through its closure:

* `adjPairs G` — the adjoint of a graph `G`, i.e. the pairs `(w, u)` with
  `⟪y, w⟫ = ⟪x, u⟫` for all `(x, y) ∈ G`; `adjGraph T = adjPairs (opGraph T)` is
  the graph of `T*`;
* **`adjGraph_eq_adjPairs_clGraph`** — `T* = (T̄)*`: the adjoint sees only the
  closure (this is the reason the adjoint of a core is the adjoint of the closed
  operator);
* **`factorGraph_eq_of_clGraph_eq`**, **`compGraph_eq_of_isClosureOf`** — the
  composite `A* ∘ Ā`, rendered as a relation, is the same for every operator
  realizing the closure, and (`factorGraph_eq_of_isCoreOf`) the same for two
  different dense cores `𝒟₁`, `𝒟₂` of one closed operator.  That is items (a)
  and (b) of the factorization question.
* **`exists_linearIsometry_of_inner_eq`** and
  **`eqOn_topologicalClosure_range_of_eqOn_range`** — item (c), the
  polar-decomposition half: two operators `B`, `C` on a common domain with
  `B*B = C*C` (as forms) are intertwined by a *linear isometry* `U` of `ran B`
  onto `ran C` with `C = U B`, and any two continuous intertwiners agree on the
  whole initial space `closure (ran B)`.  So the factorization `S = B*B` is
  unique exactly up to such a partial isometry.
* **`positive_factor_unique`** — and it is strictly unique if the factor is
  required to be positive and self-adjoint: for bounded operators, a positive
  `B` with `B² = S` is `√S`, so there is only one.

The `#print axioms` audit for this module is `Work/ClosureUniquenessAudit.lean`
(`lake build Work.ClosureUniquenessAudit`); it is kept outside the chapter graph
so that auditing does not enlarge anyone else's dependency cone — see
`BUILD_LAYOUT.md`.

## Honest boundary

Item (c) is proved here for the *form* identity `⟪Bx, By⟫ = ⟪Cx, Cy⟫` (which is
what `B*B = C*C` means on the common domain), and the strict uniqueness of the
positive factor is proved for **bounded** operators, where Mathlib's continuous
functional calculus supplies the square root.  The identity
`(A²)_F = A* Ā` itself — that the Friedrichs extension of `A²` *is* the
composite — is not proved here; this module is about the uniqueness of the
objects entering it, and no unproved statement is used as a hypothesis of any
theorem below.
-/

namespace BookProof.ClosureUniqueness

open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}

/-! ## Part 1 — the closure is unique -/

/-- `A` on `Dom` **extends** `T` on `D`. -/
def Extends (T : D →ₗ[ℂ] F) (A : Dom →ₗ[ℂ] F) : Prop :=
  ∀ v : D, ∃ h : (v : F) ∈ Dom, A ⟨(v : F), h⟩ = T v

theorem opGraph_le_of_extends {T : D →ₗ[ℂ] F} {A : Dom →ₗ[ℂ] F} (h : Extends T A) :
    opGraph T ≤ opGraph A := by
  rintro p ⟨v, rfl⟩
  obtain ⟨hv, hval⟩ := h v
  exact ⟨⟨(v : F), hv⟩, by simp [hval]⟩

/-- `A` is a **closed extension** of `T`: it extends `T` and its graph is closed. -/
def IsClosedExtension (T : D →ₗ[ℂ] F) (A : Dom →ₗ[ℂ] F) : Prop :=
  Extends T A ∧ IsClosed ((opGraph A : Submodule ℂ (F × F)) : Set (F × F))

/-- **Minimality of the graph closure**: the graph of any closed extension of `T`
contains the closure of the graph of `T`. -/
theorem clGraph_le_opGraph_of_isClosedExtension {T : D →ₗ[ℂ] F} {A : Dom →ₗ[ℂ] F}
    (h : IsClosedExtension T A) : clGraph T ≤ opGraph A := by
  intro p hp
  exact clGraph_subset_of_isClosed h.2 (fun v => opGraph_le_of_extends h.1 (mem_opGraph T v)) hp

/-- `A` is **the closure** of `T`: a minimal closed extension. -/
def IsClosureOf (T : D →ₗ[ℂ] F) (A : Dom →ₗ[ℂ] F) : Prop :=
  IsClosedExtension T A ∧ opGraph A ≤ clGraph T

theorem opGraph_eq_clGraph_of_isClosureOf {T : D →ₗ[ℂ] F} {A : Dom →ₗ[ℂ] F}
    (h : IsClosureOf T A) : opGraph A = clGraph T :=
  le_antisymm h.2 (clGraph_le_opGraph_of_isClosedExtension h.1)

/-- The graph of `clExt T` is exactly the closed graph `clGraph T`. -/
theorem opGraph_clExt (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) :
    opGraph (clExt T hdense hsym) = clGraph T := by
  apply le_antisymm
  · rintro p ⟨x, rfl⟩
    simpa using clFun_spec T x
  · intro p hp
    have hx : p.1 ∈ clDom T := mem_clDom_iff.2 ⟨p.2, by simpa using hp⟩
    refine ⟨⟨p.1, hx⟩, ?_⟩
    have : clFun T ⟨p.1, hx⟩ = p.2 := clFun_unique hdense hsym (by simpa using hp)
    simp [this]

/-- **The construction of `ChapterEsaClosure` is a closure.** -/
theorem clExt_isClosureOf (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) :
    IsClosureOf T (clExt T hdense hsym) := by
  refine ⟨⟨fun v => ⟨coe_mem_clDom T v, clExt_extends T hdense hsym v⟩, ?_⟩, ?_⟩
  · rw [opGraph_clExt T hdense hsym]
    exact clGraph_isClosed T
  · rw [opGraph_clExt T hdense hsym]

/-- **Existence of the closure** for a densely defined symmetric operator. -/
theorem exists_isClosureOf (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) : ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsClosureOf T A :=
  ⟨clDom T, clExt T hdense hsym, clExt_isClosureOf T hdense hsym⟩

/-- Two operators with the same graph have the same domain and the same values. -/
theorem eq_of_opGraph_eq {A : Dom₁ →ₗ[ℂ] F} {B : Dom₂ →ₗ[ℂ] F} (h : opGraph A = opGraph B) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (h₁ : x ∈ Dom₁) (h₂ : x ∈ Dom₂), A ⟨x, h₁⟩ = B ⟨x, h₂⟩ := by
  have key : ∀ (x : F) (h₁ : x ∈ Dom₁), ∃ h₂ : x ∈ Dom₂, B ⟨x, h₂⟩ = A ⟨x, h₁⟩ := by
    intro x h₁
    have hx : ((x : F), A ⟨x, h₁⟩) ∈ opGraph B := by
      rw [← h]; exact mem_opGraph A ⟨x, h₁⟩
    obtain ⟨w, hw⟩ := hx
    have hw1 : (w : F) = x := congrArg Prod.fst hw
    have hw2 : B w = A ⟨x, h₁⟩ := congrArg Prod.snd hw
    refine ⟨hw1 ▸ w.2, ?_⟩
    rw [← hw2]
    congr 1
    exact Subtype.ext hw1.symm
  have key' : ∀ (x : F) (h₂ : x ∈ Dom₂), ∃ h₁ : x ∈ Dom₁, A ⟨x, h₁⟩ = B ⟨x, h₂⟩ := by
    intro x h₂
    have hx : ((x : F), B ⟨x, h₂⟩) ∈ opGraph A := by
      rw [h]; exact mem_opGraph B ⟨x, h₂⟩
    obtain ⟨w, hw⟩ := hx
    have hw1 : (w : F) = x := congrArg Prod.fst hw
    have hw2 : A w = B ⟨x, h₂⟩ := congrArg Prod.snd hw
    refine ⟨hw1 ▸ w.2, ?_⟩
    rw [← hw2]
    congr 1
    exact Subtype.ext hw1.symm
  refine ⟨?_, fun x h₁ h₂ => ?_⟩
  · ext x
    exact ⟨fun hx => (key x hx).1, fun hx => (key' x hx).1⟩
  · obtain ⟨h₂', hval⟩ := key x h₁
    rw [← hval]

/-- **The closure of a symmetric operator is unique.**  Any two minimal closed
extensions of `T` have the same domain and the same values. -/
theorem closure_unique {T : D →ₗ[ℂ] F} {A : Dom₁ →ₗ[ℂ] F} {B : Dom₂ →ₗ[ℂ] F}
    (hA : IsClosureOf T A) (hB : IsClosureOf T B) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (h₁ : x ∈ Dom₁) (h₂ : x ∈ Dom₂), A ⟨x, h₁⟩ = B ⟨x, h₂⟩ :=
  eq_of_opGraph_eq
    ((opGraph_eq_clGraph_of_isClosureOf hA).trans (opGraph_eq_clGraph_of_isClosureOf hB).symm)

/-- Consequently every closure of `T` agrees with the canonical one. -/
theorem eq_clExt_of_isClosureOf {T : D →ₗ[ℂ] F} {A : Dom →ₗ[ℂ] F} (hA : IsClosureOf T A)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) :
    Dom = clDom T ∧ ∀ (x : F) (h₁ : x ∈ Dom) (h₂ : x ∈ clDom T),
      A ⟨x, h₁⟩ = clExt T hdense hsym ⟨x, h₂⟩ :=
  closure_unique hA (clExt_isClosureOf T hdense hsym)

/-! ## Part 2 — the closure need not be self-adjoint -/

/-- A deficiency vector of `T` at `i` pairs with the whole closed graph. -/
theorem clGraph_inner_deficiency {T : D →ₗ[ℂ] F} {w : F}
    (hw : ∀ v : D, (inner ℂ (T v) w : ℂ) = Complex.I * inner ℂ (v : F) w) {p : F × F}
    (hp : p ∈ clGraph T) : (inner ℂ p.2 w : ℂ) = Complex.I * inner ℂ p.1 w := by
  have hclosed : IsClosed {q : F × F | (inner ℂ q.2 w : ℂ) = Complex.I * inner ℂ q.1 w} :=
    isClosed_eq (continuous_snd.inner continuous_const)
      (continuous_const.mul (continuous_fst.inner continuous_const))
  exact clGraph_subset_of_isClosed hclosed (fun v => hw v) hp

/-- **The unique closure is not always self-adjoint.**  If `T` has a non-zero
deficiency vector at `i` — i.e. `T` is *not* essentially self-adjoint — then its
closure, which exists and is unique, fails to be a self-adjoint extension. -/
theorem not_isSelfAdjointExtension_clExt_of_deficiency (T : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) {w : F} (hw0 : w ≠ 0)
    (hw : ∀ v : D, (inner ℂ (T v) w : ℂ) = Complex.I * inner ℂ (v : F) w) :
    ¬ IsSelfAdjointExtension T (clExt T hdense hsym) := by
  rintro ⟨-, hsymA, hsa⟩
  have hpair : ∀ v : clDom T, (inner ℂ (clExt T hdense hsym v) w : ℂ)
      = inner ℂ (v : F) (Complex.I • w) := by
    intro v
    have h := clGraph_inner_deficiency hw (clFun_spec T v)
    simpa [inner_smul_right] using h
  obtain ⟨hwmem, hval⟩ := hsa w (Complex.I • w) hpair
  have hs := hsymA ⟨w, hwmem⟩ ⟨w, hwmem⟩
  rw [hval] at hs
  simp only [inner_smul_left, inner_smul_right, Complex.conj_I] at hs
  have hnorm : (inner ℂ w w : ℂ) = 0 := by
    have h2 : (2 * Complex.I) * (inner ℂ w w : ℂ) = 0 := by linear_combination -hs
    have hI : (2 * Complex.I : ℂ) ≠ 0 := by
      simp [Complex.I_ne_zero]
    exact (mul_eq_zero.mp h2).resolve_left hI
  exact hw0 (inner_self_eq_zero.mp hnorm)

/-! ## Part 3 — the closure does not depend on the core -/

/-- `T₁` is a **core** for `T₂`: `T₂` extends `T₁`, and the graph of `T₂` is
inside the closure of the graph of `T₁`. -/
def IsCoreOf (T₁ : D₁ →ₗ[ℂ] F) (T₂ : D₂ →ₗ[ℂ] F) : Prop :=
  Extends T₁ T₂ ∧ opGraph T₂ ≤ clGraph T₁

/-- **A core has the same closure.** -/
theorem clGraph_eq_of_isCoreOf {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F} (h : IsCoreOf T₁ T₂) :
    clGraph T₁ = clGraph T₂ := by
  refine le_antisymm ?_ ?_
  · exact Submodule.topologicalClosure_mono (opGraph_le_of_extends h.1)
  · intro p hp
    refine clGraph_subset_of_isClosed (clGraph_isClosed T₁) (fun v => ?_) hp
    exact h.2 (mem_opGraph T₂ v)

/-- **Two dense cores of the same closed operator have the same closure.** -/
theorem clGraph_eq_of_isCoreOf_pair {T : D →ₗ[ℂ] F} {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h₁ : IsCoreOf T₁ T) (h₂ : IsCoreOf T₂ T) : clGraph T₁ = clGraph T₂ :=
  (clGraph_eq_of_isCoreOf h₁).trans (clGraph_eq_of_isCoreOf h₂).symm

/-- The domain of the closure is core-independent. -/
theorem clDom_eq_of_clGraph_eq {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h : clGraph T₁ = clGraph T₂) : clDom T₁ = clDom T₂ := by
  unfold clDom
  rw [h]

/-! ## Part 4 — the adjoint depends only on the closure -/

/-- The **adjoint of a graph**: the pairs `(w, u)` with `⟪y, w⟫ = ⟪x, u⟫` for all
`(x, y) ∈ G`. -/
def adjPairs (G : Submodule ℂ (F × F)) : Submodule ℂ (F × F) where
  carrier := {p : F × F | ∀ q ∈ G, (inner ℂ q.2 p.1 : ℂ) = inner ℂ q.1 p.2}
  add_mem' := by
    intro p p' hp hp' q hq
    simp only [Prod.fst_add, Prod.snd_add, inner_add_right]
    rw [hp q hq, hp' q hq]
  zero_mem' := by intro q _; simp
  smul_mem' := by
    intro c p hp q hq
    simp only [Prod.smul_fst, Prod.smul_snd, inner_smul_right]
    rw [hp q hq]

/-- The **graph of the adjoint** `T*`. -/
def adjGraph (T : D →ₗ[ℂ] F) : Submodule ℂ (F × F) := adjPairs (opGraph T)

theorem mem_adjGraph_iff {T : D →ₗ[ℂ] F} {p : F × F} :
    p ∈ adjGraph T ↔ ∀ v : D, (inner ℂ (T v) p.1 : ℂ) = inner ℂ (v : F) p.2 := by
  constructor
  · intro h v; exact h _ (mem_opGraph T v)
  · rintro h q ⟨v, rfl⟩; exact h v

/-- **`T* = (T̄)*`**: the adjoint only sees the closed graph. -/
theorem adjGraph_eq_adjPairs_clGraph (T : D →ₗ[ℂ] F) : adjGraph T = adjPairs (clGraph T) := by
  refine le_antisymm ?_ ?_
  · intro p hp q hq
    have hclosed : IsClosed {r : F × F | (inner ℂ r.2 p.1 : ℂ) = inner ℂ r.1 p.2} :=
      isClosed_eq (continuous_snd.inner continuous_const) (continuous_fst.inner continuous_const)
    exact clGraph_subset_of_isClosed hclosed
      (fun v => hp _ (mem_opGraph T v)) hq
  · intro p hp q hq
    exact hp q (opGraph_le_clGraph T hq)

/-- **The adjoint is core-independent.** -/
theorem adjGraph_eq_of_clGraph_eq {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h : clGraph T₁ = clGraph T₂) : adjGraph T₁ = adjGraph T₂ := by
  rw [adjGraph_eq_adjPairs_clGraph, adjGraph_eq_adjPairs_clGraph, h]

theorem adjGraph_eq_of_isCoreOf {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F} (h : IsCoreOf T₁ T₂) :
    adjGraph T₁ = adjGraph T₂ :=
  adjGraph_eq_of_clGraph_eq (clGraph_eq_of_isCoreOf h)

/-! ## Part 5 — the factorization `A* ∘ Ā` is unique -/

/-- The composite `T* ∘ T̄`, as a relation: `(x, z)` with `T̄ x = y` and `T* y = z`. -/
def factorGraph (T : D →ₗ[ℂ] F) : Set (F × F) :=
  {p : F × F | ∃ y, (p.1, y) ∈ clGraph T ∧ (y, p.2) ∈ adjGraph T}

/-- The composite `A* ∘ A` of an operator with the adjoint of its graph. -/
def compGraph (A : Dom →ₗ[ℂ] F) : Set (F × F) :=
  {p : F × F | ∃ y, (p.1, y) ∈ opGraph A ∧ (y, p.2) ∈ adjPairs (opGraph A)}

/-- **(a) The factorization is determined by the operator**: every realization of
the closure of `T` produces the same composite `A* ∘ Ā`. -/
theorem compGraph_eq_of_isClosureOf {T : D →ₗ[ℂ] F} {A : Dom →ₗ[ℂ] F} (hA : IsClosureOf T A) :
    compGraph A = factorGraph T := by
  have hgraph : opGraph A = clGraph T := opGraph_eq_clGraph_of_isClosureOf hA
  have hadj : adjPairs (opGraph A) = adjGraph T := by
    rw [hgraph, ← adjGraph_eq_adjPairs_clGraph]
  exact Set.ext fun p => exists_congr fun y =>
    and_congr (by rw [hgraph]) (by rw [hadj])

/-- **(b) The factorization does not depend on the core.** -/
theorem factorGraph_eq_of_clGraph_eq {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h : clGraph T₁ = clGraph T₂) : factorGraph T₁ = factorGraph T₂ := by
  have hadj : adjGraph T₁ = adjGraph T₂ := adjGraph_eq_of_clGraph_eq h
  exact Set.ext fun p => exists_congr fun y =>
    and_congr (by rw [h]) (by rw [hadj])

theorem factorGraph_eq_of_isCoreOf {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F} (h : IsCoreOf T₁ T₂) :
    factorGraph T₁ = factorGraph T₂ :=
  factorGraph_eq_of_clGraph_eq (clGraph_eq_of_isCoreOf h)

/-- Two cores of one closed operator give the same factorization. -/
theorem factorGraph_eq_of_isCoreOf_pair {T : D →ₗ[ℂ] F} {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h₁ : IsCoreOf T₁ T) (h₂ : IsCoreOf T₂ T) : factorGraph T₁ = factorGraph T₂ :=
  factorGraph_eq_of_clGraph_eq (clGraph_eq_of_isCoreOf_pair h₁ h₂)

/-! ### `A* ∘ Ā` is a positive symmetric extension of `A²`

The identity `(A²)_F = A* Ā` is not proved here, but the three facts that make
the right-hand side a candidate for a Friedrichs extension of `A²` are: the
composite extends `A²`, it is symmetric, and its quadratic form `⟪x, A*Āx⟫` is
the non-negative number `‖Āx‖²`. -/

/-- The square `A²` of an operator that leaves its domain invariant. -/
def sqOp (A : D →ₗ[ℂ] F) (hstab : ∀ v : D, (A v : F) ∈ D) : D →ₗ[ℂ] F where
  toFun v := A ⟨A v, hstab v⟩
  map_add' v w := by
    have : (⟨A (v + w), hstab (v + w)⟩ : D) = ⟨A v, hstab v⟩ + ⟨A w, hstab w⟩ := by
      apply Subtype.ext; simp
    rw [this, map_add]
  map_smul' c v := by
    have : (⟨A (c • v), hstab (c • v)⟩ : D) = c • ⟨A v, hstab v⟩ := by
      apply Subtype.ext; simp
    rw [this, map_smul]; rfl

@[simp] theorem sqOp_apply (A : D →ₗ[ℂ] F) (hstab : ∀ v : D, (A v : F) ∈ D) (v : D) :
    sqOp A hstab v = A ⟨A v, hstab v⟩ := rfl

/-- **`A* Ā` extends `A²`.** -/
theorem mem_factorGraph_sqOp (A : D →ₗ[ℂ] F) (hsym : SymmetricOn D A)
    (hstab : ∀ v : D, (A v : F) ∈ D) (v : D) :
    ((v : F), sqOp A hstab v) ∈ factorGraph A := by
  refine ⟨A v, mem_clGraph_of_mem_opGraph (mem_opGraph A v), ?_⟩
  rw [mem_adjGraph_iff]
  intro u
  have h := hsym u ⟨A v, hstab v⟩
  simpa using h

/-- **`A* Ā` is symmetric.** -/
theorem factorGraph_symmetric {A : D →ₗ[ℂ] F} {p q : F × F} (hp : p ∈ factorGraph A)
    (hq : q ∈ factorGraph A) : (inner ℂ p.2 q.1 : ℂ) = inner ℂ p.1 q.2 := by
  obtain ⟨y, hy, hz⟩ := hp
  obtain ⟨y', hy', hz'⟩ := hq
  rw [adjGraph_eq_adjPairs_clGraph] at hz hz'
  have h1 : (inner ℂ y' y : ℂ) = inner ℂ q.1 p.2 := hz (q.1, y') hy'
  have h2 : (inner ℂ y y' : ℂ) = inner ℂ p.1 q.2 := hz' (p.1, y) hy
  have h3 : (inner ℂ p.2 q.1 : ℂ) = starRingEnd ℂ (inner ℂ q.1 p.2) :=
    (inner_conj_symm _ _).symm
  rw [h3, ← h1, inner_conj_symm]
  exact h2

/-- **The quadratic form of `A* Ā` is `‖Āx‖² ≥ 0`.** -/
theorem factorGraph_quadForm {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorGraph A) :
    ∃ y : F, (p.1, y) ∈ clGraph A ∧ (inner ℂ p.1 p.2 : ℂ) = ((‖y‖ ^ 2 : ℝ) : ℂ) := by
  obtain ⟨y, hy, hz⟩ := hp
  rw [adjGraph_eq_adjPairs_clGraph] at hz
  refine ⟨y, hy, ?_⟩
  have h1 : (inner ℂ y y : ℂ) = inner ℂ p.1 p.2 := hz (p.1, y) hy
  rw [← h1, inner_self_eq_norm_sq_to_K]
  norm_cast

theorem factorGraph_quadForm_nonneg {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorGraph A) :
    0 ≤ (inner ℂ p.1 p.2 : ℂ).re ∧ (inner ℂ p.1 p.2 : ℂ).im = 0 := by
  obtain ⟨y, -, hval⟩ := factorGraph_quadForm hp
  rw [hval]
  exact ⟨by rw [Complex.ofReal_re]; positivity, Complex.ofReal_im _⟩

/-! ## Part 6 — (c) uniqueness up to a partial isometry -/

/-- **The polar-decomposition half of item (c).**  If `B` and `C` on a common
domain satisfy `B*B = C*C` — i.e. `⟪Bx, By⟫ = ⟪Cx, Cy⟫` — then there is a linear
isometry `U` from `ran B` to `F` with `U (B x) = C x`, whose range is `ran C`. -/
theorem exists_linearIsometry_of_inner_eq (B C : D →ₗ[ℂ] F)
    (h : ∀ x y : D, (inner ℂ (B x) (B y) : ℂ) = inner ℂ (C x) (C y)) :
    ∃ U : LinearMap.range B →ₗ[ℂ] F,
      (∀ x : D, U ⟨B x, LinearMap.mem_range_self B x⟩ = C x) ∧
      (∀ z : LinearMap.range B, ‖U z‖ = ‖(z : F)‖) ∧
      LinearMap.range U = LinearMap.range C := by
  have hnorm : ∀ x : D, ‖C x‖ = ‖B x‖ := by
    intro x
    have hx := h x x
    rw [inner_self_eq_norm_sq_to_K (𝕜 := ℂ), inner_self_eq_norm_sq_to_K (𝕜 := ℂ)] at hx
    have hsq : (‖B x‖ : ℝ) ^ 2 = (‖C x‖ : ℝ) ^ 2 := by exact_mod_cast hx
    nlinarith [norm_nonneg (B x), norm_nonneg (C x)]
  have hker : LinearMap.ker B ≤ LinearMap.ker C := by
    intro x hx
    have hx0 : B x = 0 := hx
    have : ‖C x‖ = 0 := by rw [hnorm x, hx0, norm_zero]
    simpa [LinearMap.mem_ker] using norm_eq_zero.mp this
  set f := (LinearMap.ker B).liftQ C hker with hf
  set U := f.comp (B.quotKerEquivRange.symm : LinearMap.range B →ₗ[ℂ] (D ⧸ LinearMap.ker B))
    with hU
  have hval : ∀ x : D, U ⟨B x, LinearMap.mem_range_self B x⟩ = C x := by
    intro x
    have he : B.quotKerEquivRange (Submodule.Quotient.mk x)
        = ⟨B x, LinearMap.mem_range_self B x⟩ := by
      apply Subtype.ext
      simp [LinearMap.quotKerEquivRange_apply_mk B x]
    have hsymm : B.quotKerEquivRange.symm ⟨B x, LinearMap.mem_range_self B x⟩
        = Submodule.Quotient.mk x := by
      rw [← he, LinearEquiv.symm_apply_apply]
    simp [hU, hsymm, hf, Submodule.liftQ_apply]
  refine ⟨U, hval, ?_, ?_⟩
  · rintro ⟨z, x, rfl⟩
    rw [hval x]
    exact hnorm x
  · ext y
    constructor
    · rintro ⟨⟨z, x, rfl⟩, rfl⟩
      exact ⟨x, (hval x).symm ▸ rfl⟩
    · rintro ⟨x, rfl⟩
      exact ⟨⟨B x, LinearMap.mem_range_self B x⟩, hval x⟩

/-- Any two continuous intertwiners agree on the whole **initial space**
`closure (ran B)`: the partial isometry of item (c) is unique there. -/
theorem eqOn_topologicalClosure_range_of_eqOn_range (B : D →ₗ[ℂ] F) (U V : F →L[ℂ] F)
    (h : ∀ x : D, U (B x) = V (B x)) :
    ∀ z ∈ (LinearMap.range B).topologicalClosure, U z = V z := by
  intro z hz
  have hclosed : IsClosed {y : F | U y = V y} := isClosed_eq U.continuous V.continuous
  have hsub : ((LinearMap.range B : Submodule ℂ F) : Set F) ⊆ {y : F | U y = V y} := by
    rintro _ ⟨x, rfl⟩
    exact h x
  have := closure_minimal hsub hclosed
  exact this (by simpa [Submodule.topologicalClosure_coe] using hz)

/-! ## Part 7 — (c) the positive self-adjoint factor is strictly unique -/

open ContinuousLinearMap in
/-- **A positive self-adjoint factor is unique.**  For bounded operators on a
Hilbert space, if `B, C ≥ 0` and `B² = C²`, then `B = C`: both are `√(B²)`. -/
theorem positive_factor_unique {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
    [CompleteSpace H] (B C : H →L[ℂ] H) (hB : B.IsPositive) (hC : C.IsPositive)
    (h : B ∘L B = C ∘L C) : B = C := by
  have hB' : (0 : H →L[ℂ] H) ≤ B := (nonneg_iff_isPositive B).mpr hB
  have hC' : (0 : H →L[ℂ] H) ≤ C := (nonneg_iff_isPositive C).mpr hC
  have hsB : star B = B := hB.isSelfAdjoint
  have hsC : star C = C := hC.isSelfAdjoint
  have hBB : (0 : H →L[ℂ] H) ≤ B * B := by
    have := star_mul_self_nonneg B; rwa [hsB] at this
  have hCC : (0 : H →L[ℂ] H) ≤ C * C := by
    have := star_mul_self_nonneg C; rwa [hsC] at this
  have h1 : CFC.sqrt (B * B) = B := (CFC.sqrt_eq_iff (B * B) B hBB hB').2 rfl
  have h2 : CFC.sqrt (C * C) = C := (CFC.sqrt_eq_iff (C * C) C hCC hC').2 rfl
  have hmul : B * B = C * C := h
  rw [← h1, ← h2, hmul]

/-! ## Part 8 — the Faris–Lavine application

The reason the questions above matter here: the Faris–Lavine criterion produces
*essential self-adjointness on a core*, and what the applications use is the
closure.  Combining the criterion with Parts 1 and 3 gives the complete package
for an operator satisfying its hypotheses. -/

section FarisLavineApplication

variable [CompleteSpace F]

/-- **Faris–Lavine: the closure is the unique self-adjoint realization.**  Under
the hypotheses of `BookProof.FarisLavine.essentiallySelfAdjointOn_of_farisLavine`
the closure of `H` (unique by `closure_unique`) is a self-adjoint extension, and
every self-adjoint extension of `H` is that same operator. -/
theorem farisLavine_closure_isSelfAdjoint_unique (H N : D →ₗ[ℂ] F) (c : ℝ)
    (hdense : Dense (D : Set F)) (hH : SymmetricOn D H) (hN : SymmetricOn D N) (hc : 0 ≤ c)
    (hNpos : ∀ x : D, 0 ≤ quadForm N x)
    (hNsurj : ∀ f : F, ∃ x : D, N x + (x : F) = f)
    (hcomm : ∀ x : D, |commForm H N x| ≤ c * quadForm N x) :
    IsClosureOf H (clExt H hdense hH) ∧ IsSelfAdjointExtension H (clExt H hdense hH) ∧
      ∀ {Dom : Submodule ℂ F} (A : Dom →ₗ[ℂ] F), IsSelfAdjointExtension H A →
        Dom = clDom H ∧ ∀ (x : F) (h : x ∈ Dom) (h' : x ∈ clDom H),
          A ⟨x, h⟩ = clExt H hdense hH ⟨x, h'⟩ := by
  have hesa : EssentiallySelfAdjointOn D H :=
    essentiallySelfAdjointOn_of_farisLavine H N c hH hN hc hNpos hNsurj hcomm
  have hSA : IsSelfAdjointExtension H (clExt H hdense hH) :=
    ⟨fun v => ⟨coe_mem_clDom H v, clExt_extends H hdense hH v⟩,
      clExt_symmetricOn H hdense hH,
      clExt_selfAdjointCriterion H hdense hH hesa⟩
  exact ⟨clExt_isClosureOf H hdense hH, hSA,
    fun A hA => isSelfAdjointExtension_unique_of_esa hesa hA hSA⟩

omit [CompleteSpace F] in
/-- **Faris–Lavine is core-independent.**  Two cores of one operator have the same
closure, hence the same self-adjoint realization; it is enough to verify the
commutator hypotheses on either one. -/
theorem farisLavine_clGraph_eq_of_cores {T : D →ₗ[ℂ] F} {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h₁ : IsCoreOf T₁ T) (h₂ : IsCoreOf T₂ T) :
    clGraph T₁ = clGraph T₂ ∧ clDom T₁ = clDom T₂ ∧ adjGraph T₁ = adjGraph T₂ := by
  have h := clGraph_eq_of_isCoreOf_pair h₁ h₂
  exact ⟨h, clDom_eq_of_clGraph_eq h, adjGraph_eq_of_clGraph_eq h⟩

end FarisLavineApplication

/-- The same statement in the shape of the question: a positive self-adjoint
square root of a given bounded operator `S` is unique. -/
theorem positive_sqrt_unique {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
    [CompleteSpace H] (S B C : H →L[ℂ] H) (hB : B.IsPositive) (hC : C.IsPositive)
    (hBS : B ∘L B = S) (hCS : C ∘L C = S) : B = C :=
  positive_factor_unique B C hB hC (by rw [hBS, hCS])

end BookProof.ClosureUniqueness
