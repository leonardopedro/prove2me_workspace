import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavine
import Mathlib


/-!
# Essential self-adjointness selects a **unique** self-adjoint operator

Every essential-self-adjointness theorem of this development — the Faris–Lavine
chain of `BookProof.ChapterFarisLavine`, the Navier–Stokes sequence-space chain
(`BilinearEsa`, `AffineFiber`, `AffineBlock`, `SignFlip`, `SignedShift`,
`ThreeComponent`), the Hermite-core theorems of the gravity and Yang–Mills
routes — is stated as *trivial deficiency*: the only vector `w` with
`⟪T v, w⟫ = ± i ⟪v, w⟫` for every `v` in the core is `w = 0`
(`BookProof.FarisLavine.EssentiallySelfAdjointOn`).

That is the classical criterion, but it is a statement *about* the operator on
the core; the object the physics needs — the self-adjoint generator whose
unitary group is the flow, and the operator whose resolvent the
Hashimoto/SIRK algorithm computes — is the **closure**.  This module builds it
and proves the two facts that make "essentially self-adjoint" mean what it says:

* `exists_isSelfAdjointExtension_of_esa` — **existence**: a densely defined
  symmetric operator with trivial deficiency has a self-adjoint extension,
  namely the closure of its graph.  The construction is explicit
  (`clGraph`, `clDom`, `clExt`), and no positivity, boundedness or
  semiboundedness hypothesis is used.
* `isSelfAdjointExtension_unique_of_esa` — **uniqueness**: *any* self-adjoint
  extension of an essentially self-adjoint operator has the same domain and the
  same values.  So the closure is the only self-adjoint operator the core
  determines.

`IsSelfAdjointExtension` is the positivity-free companion of
`BookProof.YangMillsFriedrichs.IsPositiveSelfAdjointExtension`;
`isSelfAdjointExtension_of_positive` records that a positive self-adjoint
extension is one.

## The Hashimoto/SIRK consequence

`BookProof.ChapterHashimotoComplexShifts` runs the shift-invert rational Krylov
algorithm at non-real shifts, where positivity of the operator is not needed —
only symmetry and the self-adjointness criterion.  Its headline
(`hashimoto_multishift_selects_friedrichs`) was nevertheless stated for a
*positive* self-adjoint extension.  `hashimoto_multishift_selects_esa` removes
the positivity hypothesis and feeds it the closure produced here: for an
essentially self-adjoint operator on a dense core, and for an arbitrary
sequence of non-real shifts, the resolvents `X_j = (γ_j − A)⁻¹` exist, are
bounded by `1/|Im γ_j|`, satisfy the resolvent identity and the SIRK relation,
have Galerkin truncations converging strongly, and each one of them determines
`A` — the *unique* self-adjoint extension — completely.

## Honest boundary

Nothing here is a statement about any particular differential operator; it is
the abstract von Neumann theory (deficiency indices `(0,0)` ⟹ unique
self-adjoint extension) that the concrete chapters instantiate.
-/

open Filter Topology

namespace BookProof.EsaClosure

open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

/-! ## Part 1 — the graph and its closure -/

/-- The graph `{(x, T x) : x ∈ D}` of `T`, as a submodule of `F × F`. -/
def opGraph (T : D →ₗ[ℂ] F) : Submodule ℂ (F × F) :=
  LinearMap.range (D.subtype.prod T)



theorem opGraph_eq_range (T : D →ₗ[ℂ] F) :
    (opGraph T : Set (F × F)) = Set.range fun v : D => ((v : F), T v) := by
  ext p
  constructor
  · rintro ⟨v, rfl⟩; exact ⟨v, rfl⟩
  · rintro ⟨v, rfl⟩; exact ⟨v, rfl⟩

/-- The **closure of the graph** of `T`. -/
def clGraph (T : D →ₗ[ℂ] F) : Submodule ℂ (F × F) := (opGraph T).topologicalClosure







/-- Every point of the closed graph is a limit point in the topological sense:
membership can be checked against any closed set containing the graph. -/
theorem clGraph_subset_of_isClosed {T : D →ₗ[ℂ] F} {S : Set (F × F)} (hS : IsClosed S)
    (hsub : ∀ v : D, ((v : F), T v) ∈ S) :
    ((clGraph T : Submodule ℂ (F × F)) : Set (F × F)) ⊆ S := by
  have h : (opGraph T : Set (F × F)) ⊆ S := by
    rw [opGraph_eq_range]
    rintro _ ⟨v, rfl⟩
    exact hsub v
  simpa [clGraph, Submodule.topologicalClosure_coe] using closure_minimal h hS

/-- **The closed graph is still a graph of the adjoint pairing**: every pair
`(x, y)` in the closure satisfies `⟪y, v⟫ = ⟪x, T v⟫` for `v` in the core. -/
theorem clGraph_inner {T : D →ₗ[ℂ] F} (hsym : SymmetricOn D T) {p : F × F}
    (hp : p ∈ clGraph T) (v : D) : (inner ℂ p.2 (v : F) : ℂ) = inner ℂ p.1 (T v) := by
  have hclosed : IsClosed {q : F × F | (inner ℂ q.2 (v : F) : ℂ) = inner ℂ q.1 (T v)} :=
    isClosed_eq (continuous_snd.inner continuous_const) (continuous_fst.inner continuous_const)
  exact clGraph_subset_of_isClosed hclosed (fun u => hsym u v) hp



/-- **Closability**: a densely defined symmetric operator has a graph whose
closure is again a graph — the fibre over `0` is trivial. -/
theorem clGraph_snd_eq_zero_of_fst_eq_zero {T : D →ₗ[ℂ] F} (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) {y : F} (h : ((0 : F), y) ∈ clGraph T) : y = 0 := by
  refine Dense.eq_zero_of_inner_left (𝕜 := ℂ) hdense (fun v hv => ?_)
  have := clGraph_inner hsym h ⟨v, hv⟩
  simpa using this

/-- The **domain of the closure**: the first projection of the closed graph. -/
def clDom (T : D →ₗ[ℂ] F) : Submodule ℂ F := (clGraph T).map (LinearMap.fst ℂ F F)

theorem mem_clDom_iff {T : D →ₗ[ℂ] F} {x : F} : x ∈ clDom T ↔ ∃ y, (x, y) ∈ clGraph T := by
  constructor
  · rintro ⟨p, hp, rfl⟩
    exact ⟨p.2, hp⟩
  · rintro ⟨y, hy⟩
    _opGraph (mem_opGraph T v)⟩

/-- The value of the closure at a point of its domain (chosen; unique by
`clFun_unique`). -/
noncomputable def clFun (T : D →ₗ[ℂ] F) (x : clDom T) : F :=
  Classical.choose (mem_clDom_iff.1 x.2)

theorem clFun_spec (T : D →ₗ[ℂ] F) (x : clDom T) : ((x : F), clFun T x) ∈ clGraph T :=
  Classical.choose_spec (mem_clDom_iff.1 x.2)

theorem clFun_unique {T : D →ₗ[ℂ] F} (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    {x : clDom T} {y : F} (h : ((x : F), y) ∈ clGraph T) : clFun T x = y := by
  have hz : ((0 : F), clFun T x - y) ∈ clGraph T := by
    have := Submodule.sub_mem (clGraph T) (clFun_spec T x) h
    simpa using this
  exact sub_eq_zero.mp (clGraph_snd_eq_zero_of_fst_eq_zero hdense hsym hz)

/-- **The closure of `T`**, as a linear operator on `clDom T`. -/
noncomputable def clExt (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) :
    clDom T →ₗ[ℂ] F where
  toFun := clFun T
  map_add' x y := by
    refine clFun_unique hdense hsym ?_
    have := Submodule.add_mem (clGraph T) (clFun_spec T x) (clFun_spec T y)
    simpa using this
  map_smul' c x := by
    refine clFun_unique hdense hsym ?_
    have := Submodule.smul_mem (clGraph T) c (clFun_spec T x)
    simpa using this

@[simp] theorem clExt_apply (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T)
    (x : clDom T) : clExt T hdensemun fun n => clFun_spec T (x n))

/-- "`A` on `Dom` is a self-adjoint extension of `H` on `D`": the positivity-free
companion of `BookProof.YangMillsFriedrichs.IsPositiveSelfAdjointExtension`
(`BookProof.EsaClosure.isSelfAdjointExtension_of_positive`, in
`BookProof.ChapterEsaClosure`, derives this from that). -/
def IsSelfAdjointExtension {D Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (A : Dom →ₗ[ℂ] F) : Prop :=
  (∀ x : D, ∃ h : (x : F) ∈ Dom, A ⟨(x : F), h⟩ = H x) ∧ SymmetricOn Dom A ∧
    (∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)

/-! ## Part 2 — the closure is self-adjoint -/

section SelfAdjoint
hAt [hxvointCriterion T hdense hsym hesa⟩l⟩ := key x h
    exact hval.symm

end SelfAdjoint

/-! ## Part 4 — the Cayley transform: the generator produces a unitary -/

section Cayley

variable [Completnn :A, U, ⟨hext, hsymA, hsa⟩, hU⟩

end Cayley


end BookProof.EsaClosure
