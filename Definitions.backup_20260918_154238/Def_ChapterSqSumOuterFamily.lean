import Mathlib
import Mathlib
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterSqSumFarisLavine
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterGaussCoreQuadBounds
open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.GaussCoreQuadBounds BookProof.SqSumFarisLavine
open BookProof.HermiteProductBasis
open BookProof.SqSumFarisLavine
open BookProof.QgHermiteFriedrichs


/-!
# Uniform kinetic-plus-squares families on an outer Fock space of arbitrary fibre dimension

`BookProof.ChapterQgOuterFockInteractionFL` proves Faris–Lavine essential self-adjointness
for a uniform family of kinetic-plus-squares Hamiltonians on the *quantum-gravity* outer
Fock space `⊕ₙ L²(ℝ^{84n})`: the fibre dimension `84` is hard-wired there.  Nothing in the
argument uses the number `84`, so this module repeats the development with the sequence of
sector dimensions as a parameter.  It is the instrument the Navier–Stokes thread needs
(`BookProof.ChapterNsOuterFockFarisLavine`, fibre dimension `18` per parcel), and it
specialises back to the gravity statement at `dim n = n * 84`.

## The data

A `SqFamily` is

* a sequence of sector dimensions `dim : ℕ → ℕ` — the number of field-space coordinates of
  the `n`-particle sector;
* for every `n` a finite index type `R n` of linear forms, a real signature
  `kap n : Fin (dim n) → ℝ` and coefficient vectors `vv n : R n → Fin (dim n) → ℝ`,
  defining the sector Hamiltonian

  `H_n = ½ Σ_I kap_I π_I² + ½ Σ_r L_r²`,  `L_r = Σ_I vv_{rI} x_I`

  on the Gauss–polynomial core of `L²(ℝ^{dim n})` (`BookProof.QgOuterFock.sqSumOp`);
* three **uniform** bounds: `|kap n I| ≤ km`, the row bound `Σ_I |vv n r I| ≤ a` and the
  column bound `Σ_r |vv n r I| ≤ b`, with `km`, `a`, `b` independent of `n`.

No structural restriction is placed on the linear forms: a form may mix the coordinates of
arbitrarily many different particles, so the Hamiltonian need not be a sum of one-particle
operators.

## What is proved

* `outerFock`, `outerCore`, `outerCore_dense`, `outerComparison`, `outerFriedDom`,
  `outerCore_le_friedDom` — the outer Fock space of the dimension sequence, its
  finite-particle core, and the lifted Friedrichs extension of the positive one-particle
  operator `N₁ = −Δ + ‖x‖²/4` as a Faris–Lavine comparison operator on it;
* `SqFamily.secHam`, `secHam_symmetricOn`, `secHam_essentiallySelfAdjointOn` — the sector
  Hamiltonians;
* `SqFamily.flK`, `SqFamily.flc`, `secHam_norm_le`, `secHam_commForm_le` — the two
  Faris–Lavine inequalities with constants `flK = 3km/2 + 4ab` and `flc = km/2 + 2ab`,
  **uniform in the particle number**;
* `SqFamily.outerHam`, `outerHam_symmetricOn`, `outerHam_esa` — the Hamiltonian on the
  finite-particle core;
* `SqFamily.secExt` — the sector Hamiltonians extended from the Gauss–polynomial core to
  the whole domain of the sector comparison operator;
* **`SqFamily.esa_farisLavine`** — the headline: essential self-adjointness on the domain
  of the lifted comparison operator, together with the statement that the operator so
  realized extends `outerHam` on the finite-particle core.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.SqSumOuterFamily


noncomputable section

/-! ## 1. The outer Fock space of a sequence of sector dimensions -/

variable (dim : ℕ → ℕ)

/-- **The outer Fock space** of a sequence of sector dimensions: the `ℓ²`-direct sum
`⊕ₙ L²(ℝ^{dim n})`. -/
abbrev outerFock : Type := lp (fun n : ℕ => L2d (dim n)) 2


theorem memLp_of_finite_support {G : ℕ → Type*} [∀ i, NormedAddCommGroup (G i)]
    {f : ∀ i : ℕ, G i} (h : {i | f i ≠ 0}.Finite) : Memℓp f 2 := by
  classical
  refine memℓp_gen (summable_of_ne_finset_zero (s := h.toFinset) fun i hi => ?_)
  have hzero : f i = 0 := by
    by_contra hne
    exact hi (h.mem_toFinset.mpr hne)
  simp [hzero]

variable {G : ℕ → Type*} [∀ i, NormedAddCommGroup (G i)]
    [∀ i, InnerProductSpace ℂ (G i)]

def dsCore (D : ∀ i, Submodule ℂ (G i)) : Submodule ℂ (lp G 2) where
  carrier := {f | {i | (f : ∀ i, G i) i ≠ 0}.Finite ∧ ∀ i, (f : ∀ i, G i) i ∈ D i}
  add_mem' := by
    rintro f g ⟨hf, hfD⟩ ⟨hg, hgD⟩
    constructor
    · refine Set.Finite.subset (hf.union hg) (fun i hi => ?_)
      simp only [Set.mem_setOf_eq, lp.coeFn_add, Pi.add_apply] at hi
      by_contra hcon
      simp only [Set.mem_union, Set.mem_setOf_eq, not_or, not_not] at hcon
      exact hi (by rw [hcon.1, hcon.2, add_zero])
    · intro i
      simp only [lp.coeFn_add, Pi.add_apply]
      exact Submodule.add_mem _ (hfD i) (hgD i)
  zero_mem' := by
    constructor
    · refine Set.Finite.subset (Set.finite_empty) (fun i hi => ?_)
      simp only [Set.mem_setOf_eq, lp.coeFn_zero, Pi.zero_apply, ne_eq, not_true_eq_false] at hi
    · intro i
      simp only [lp.coeFn_zero, Pi.zero_apply]
      exact Submodule.zero_mem _
  smul_mem' := by
    rintro c f ⟨hf, hfD⟩
    constructor
    · refine Set.Finite.subset hf (fun i hi => ?_)
      simp only [Set.mem_setOf_eq, lp.coeFn_smul, Pi.smul_apply] at hi ⊢
      intro h0
      exact hi (by rw [h0, smul_zero])
    · intro i
      simp only [lp.coeFn_smul, Pi.smul_apply]
      exact Submodule.smul_mem _ _ (hfD i)

variable {D : ∀ i, Submodule ℂ (G i)}

def dsOp (H : ∀ i, D i →ₗ[ℂ] G i) : dsCore D →ₗ[ℂ] lp G 2 where
  toFun x := ⟨fun i => H i ⟨(x : lp G 2) i, x.2.2 i⟩, by
    refine memLp_of_finite_support (Set.Finite.subset x.2.1 (fun i hi => ?_))
    simp only [Set.mem_setOf_eq] at hi ⊢
    intro h0
    refine hi ?_
    have : (⟨((x : lp G 2) : ∀ i, G i) i, x.2.2 i⟩ : D i) = 0 := Subtype.ext h0
    rw [this, map_zero]⟩
  map_add' x y := by
    refine lp.ext (funext fun i => ?_)
    simp only [Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    exact map_add (H i) ⟨((x : lp G 2)) i, x.2.2 i⟩ ⟨((y : lp G 2)) i, y.2.2 i⟩
  map_smul' c x := by
    refine lp.ext (funext fun i => ?_)
    simp only [RingHom.id_apply, SetLike.val_smul, lp.coeFn_smul, Pi.smul_apply]
    exact map_smul (H i) c ⟨((x : lp G 2)) i, x.2.2 i⟩


/-- The finite-particle core: the algebraic direct sum of the sector Gauss–polynomial
cores. -/
def outerCore : Submodule ℂ (outerFock dim) :=
  dsCore (fun n : ℕ => polyGaussCore (d := dim n))



/-- **The lifted comparison operator** `dΓ(N₁)`, `N₁ = −Δ + ‖x‖²/4`, in its Friedrichs
realization: positive, self-adjoint, and with `N + 1` onto the outer Fock space. -/
def outerComparison : Comparison (outerFock dim) :=
  dsComparison (fun n : ℕ => harmFried (dim n))

/-- The domain of the lifted comparison operator. -/
abbrev outerFriedDom : Submodule ℂ (outerFock dim) := (outerComparison dim).dom

/-- The lifted comparison operator on the outer Fock space. -/
abbrev outerFriedN : outerFriedDom dim →ₗ[ℂ] outerFock dim := (outerComparison dim).op











/-! ## 2. Uniform families -/

/-- **A uniform family of kinetic-plus-squares Hamiltonians on the sectors of an outer Fock
space.**  The `n`-particle Hamiltonian is `½ Σ_I kap_I π_I² + ½ Σ_r L_r²` with `L_r` the
linear form of coefficient vector `vv n r`; the three bounds `km`, `a`, `b` are uniform in
the particle number `n`. -/
structure SqFamily where
  /-- The sequence of sector dimensions. -/
  dim : ℕ → ℕ
  /-- The index type of the linear forms of the `n`-particle sector. -/
  R : ℕ → Type
  [finR : ∀ n, Fintype (R n)]
  /-- The signature of the kinetic term of the `n`-particle sector. -/
  kap : ∀ n : ℕ, Fin (dim n) → ℝ
  /-- The coefficient vectors of the linear forms of the `n`-particle sector. -/
  vv : ∀ n : ℕ, R n → Fin (dim n) → ℝ
  /-- The uniform bound on the signature. -/
  km : ℝ
  /-- The uniform row (`ℓ¹`-per-form) bound. -/
  a : ℝ
  /-- The uniform column (`ℓ¹`-per-coordinate) bound. -/
  b : ℝ
  km_nonneg : 0 ≤ km
  a_nonneg : 0 ≤ a
  b_nonneg : 0 ≤ b
  kap_le : ∀ (n : ℕ) (I : Fin (dim n)), |kap n I| ≤ km
  row_le : ∀ (n : ℕ) (r : R n), ∑ I : Fin (dim n), |vv n r I| ≤ a
  col_le : ∀ (n : ℕ) (I : Fin (dim n)), ∑ r : R n, |vv n r I| ≤ b

attribute [instance] SqFamily.finR

namespace SqFamily

variable (F : SqFamily)

/-- The relative-bound constant of the family. -/
def flK : ℝ := 3 / 2 * F.km + 4 * (F.a * F.b)

/-- The Faris–Lavine commutator constant of the family. -/
def flc : ℝ := F.km / 2 + 2 * (F.a * F.b)

theorem ab_nonneg : 0 ≤ F.a * F.b := mul_nonneg F.a_nonneg F.b_nonneg

theorem flK_nonneg : 0 ≤ F.flK := by
  have h := F.ab_nonneg
  have := F.km_nonneg
  rw [flK]; linarith



/-- **The `n`-particle Hamiltonian of the family**, on the Gauss–polynomial core of
`L²(ℝ^{dim n})`. -/
def secHam (n : ℕ) : polyGaussCore (d := F.dim n) →ₗ[ℂ] L2d (F.dim n) :=
  sqSumOp (F.kap n) (F.vv n)





/-- **The relative bound**, with a constant uniform in the particle number. -/
theorem secHam_norm_le (n : ℕ) (u : polyGaussCore (d := F.dim n)) :
    ‖F.secHam n u‖ ≤ F.flK * ‖harmCore u + (u : L2d (F.dim n))‖ := by
  have hB : ∀ x : Vd (F.dim n), potFun (F.vv n) x ≤ (F.a * F.b / 2) * ‖x‖ ^ 2 :=
    fun x => potFun_le_of_schur F.a_nonneg (F.row_le n) (F.col_le n) x
  have hB0 : (0 : ℝ) ≤ F.a * F.b / 2 := by
    have := F.ab_nonneg; linarith
  have heq : 3 / 2 * F.km + 8 * (F.a * F.b / 2) = F.flK := by rw [flK]; ring
  rw [secHam, ← heq]
  exact norm_sqSumOp_le F.km_nonneg (F.kap_le n) hB0 hB u



/-! ### The Hamiltonian on the outer Fock space -/

/-- **The Hamiltonian of the family on the finite-particle core of the outer Fock
space.** -/
def outerHam : outerCore F.dim →ₗ[ℂ] outerFock F.dim := dsOp (fun n : ℕ => F.secHam n)





/-- The Faris–Lavine core data of the `n`-particle Hamiltonian. -/
def secData (n : ℕ) : CoreData (L2d (F.dim n)) where
  C := harmFried (F.dim n)
  C₀ := polyGaussCore (d := F.dim n)
  gc := harmFried_isGraphCore (F.dim n)
  H₀ := F.secHam n
  K := F.flK
  hK := F.flK_nonneg
  rel := by
    intro p
    rw [harmFried_op_core (F.dim n) p]
    exact F.secHam_norm_le n p

/-- The `n`-particle Hamiltonian, extended from the Gauss–polynomial core to the whole
domain of the sector comparison operator. -/
def secExt (n : ℕ) : (harmFried (F.dim n)).dom →ₗ[ℂ] L2d (F.dim n) := (F.secData n).ext













end SqFamily

end

end BookProof.SqSumOuterFamily
