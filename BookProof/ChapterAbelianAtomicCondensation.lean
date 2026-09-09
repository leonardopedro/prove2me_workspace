import Mathlib
import BookProof.ChapterAbelianDiagonalCountable
import BookProof.ChapterAtomicDecomposition

/-!
# The purely atomic condensation of the abelian von Neumann classification
(plan GAP-2)

`ChapterAbelianDiagonal` (type `Iₙ`), `ChapterAbelianDiagonalCountable`
(type `I∞`, `ℓ∞(ℕ)`), `ChapterLinftyMultiplication` (the diffuse class `L∞(μ)`) and
`ChapterAbelianMixture` (the mixed class) realize the four concrete classes of von
Neumann's list.  The *exhaustiveness* of the five-way list — every abelian von
Neumann algebra on a separable `L²` is `*`-isomorphic to one of them — is the full
von Neumann theorem and is out of reach of the current toolchain (Mathlib has no
von Neumann algebra classification, no bicommutant theorem for these algebras).

What this module proves is the **purely atomic condensation** the plan asks for:
in the purely atomic case the classification *is* provable, and it collapses to
`ℓ∞(ℕ)` (or, in the finite case, to `Iₙ`).

## Deliverables

* `atomProj i` — the minimal (rank-one, "atomic") projections of `ℓ²(ℕ)`;
* `commutes_atomProj_iff` — **the condensation step**: a bounded operator commutes
  with *every atomic projection* iff it is a diagonal multiplication operator.
  Only the atoms are needed; the whole diagonal algebra is not assumed;
* `IsAtomicAbelian` — an algebra of operators is *purely atomic abelian* when it
  contains every atomic projection and its elements commute pairwise;
* `atomic_abelian_subset_diagonal` — every such algebra consists of diagonal
  operators, so `diagOp` identifies it with a subalgebra of `ℓ∞(ℕ)`;
* `atomic_abelian_maximal_eq_diagonal` — **headline**: a purely atomic abelian
  algebra that is *maximal* abelian is exactly the diagonal algebra, i.e.
  `*`-isomorphic to `ℓ∞(ℕ)` via the unital `*`-map `diagOp`
  (`diagOp_injective`, `diagOp_add`, `diagOp_mul`, `diagOp_one`, `diagOp_star`);
* `atomic_measure_index_dichotomy` — the measure-theoretic side of the same
  condensation: a purely atomic probability measure has a countable atom set, so
  the index set is either `Fin n` (class `Iₙ`) or `ℕ` (class `ℓ∞(ℕ)`); there is no
  third purely atomic class.

## Documented obstruction (GAP-2, unchanged)

The step that remains beyond this condensation is the *diffuse* half: that an
abelian von Neumann algebra whose projections are not purely atomic contains a
copy of `L∞[0,1]`, and that the general algebra splits as an atomic part plus a
diffuse part.  In the measure-theoretic model that splitting *is* available
(`ChapterAtomicDecomposition.eq_continuousPart_add_atomicPart`,
`probability_measure_five_types`); what is missing is the passage from an abstract
von Neumann algebra to a measure model — the spectral/Gelfand step — for which
Mathlib currently has no `L∞(μ)`-valued spectral theorem for abelian von Neumann
algebras.  This is recorded as an obstruction, never as a `sorry`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped ENNReal

noncomputable section

namespace BookProof.ChapterAbelianAtomicCondensation

open BookProof.ChapterAbelianDiagonalCountable

/-! ## The atomic projections and the condensation step -/

/-- The `i`-th **atomic projection** of `ℓ²(ℕ)`: the rank-one projection onto the
`i`-th coordinate axis, realized as a diagonal multiplication operator. -/
def atomProj (i : ℕ) : Ell2C →L[ℂ] Ell2C := diagOp (coordUnit i)

theorem atomProj_apply (i : ℕ) (f : Ell2C) : atomProj i f = (f : ℕ → ℂ) i • atom i :=
  diagOp_coordUnit_eq i f

/-- The atomic projections are idempotent. -/
theorem atomProj_idem (i : ℕ) : (atomProj i).comp (atomProj i) = atomProj i := by
  rw [atomProj, ← diagOp_mul]
  congr 1
  apply lp.ext
  funext j
  by_cases h : j = i
  · subst h; simp [coordUnit, lp.single_apply]
  · simp [coordUnit, lp.single_apply, h]

/-- **The condensation step.**  A bounded operator on `ℓ²(ℕ)` commutes with every
*atomic* projection if and only if it is a diagonal multiplication operator.  Only
the minimal projections are used: purely atomic commutation already forces
diagonality. -/
theorem commutes_atomProj_iff (T : Ell2C →L[ℂ] Ell2C) :
    (∀ i : ℕ, T.comp (atomProj i) = (atomProj i).comp T) ↔ ∃ d : EllInf, T = diagOp d := by
  constructor
  · intro hT
    set c : ℕ → ℂ := fun i => ((T (atom i) : Ell2C) : ℕ → ℂ) i with hc
    have hbdd : ∀ i, ‖c i‖ ≤ ‖T‖ := by
      intro i
      calc ‖c i‖ ≤ ‖T (atom i)‖ := lp.norm_apply_le_norm (by simp) _ i
        _ ≤ ‖T‖ * ‖atom i‖ := T.le_opNorm _
        _ = ‖T‖ := by rw [norm_atom, mul_one]
    have hmem : Memℓp c ∞ := by
      refine memℓp_infty ⟨‖T‖, ?_⟩
      rintro x ⟨i, rfl⟩
      exact hbdd i
    refine ⟨⟨c, hmem⟩, ?_⟩
    ext f i
    have hcomm := congrArg (fun S => ((S f : Ell2C) : ℕ → ℂ) i) (hT i)
    simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at hcomm
    have hleft : T (atomProj i f) = (f : ℕ → ℂ) i • T (atom i) := by
      rw [atomProj_apply, map_smul]
    rw [hleft] at hcomm
    have hright : ((atomProj i (T f) : Ell2C) : ℕ → ℂ) i = ((T f : Ell2C) : ℕ → ℂ) i := by
      rw [atomProj, diagOp_coordUnit_apply]; simp
    rw [hright] at hcomm
    have hval : ((f : ℕ → ℂ) i • T (atom i) : Ell2C) i = (f : ℕ → ℂ) i * c i := rfl
    rw [hval] at hcomm
    rw [← hcomm, diagOp_apply]
    simp [mul_comm]
  · rintro ⟨d, rfl⟩
    intro i
    exact diagOp_comm d (coordUnit i)

/-! ## Purely atomic abelian algebras -/

/-- An algebra of operators on `ℓ²(ℕ)` is **purely atomic abelian** when it
contains every atomic (minimal) projection and its elements commute pairwise.
This is the operator-algebraic form of "the projections of the algebra are purely
atomic". -/
structure IsAtomicAbelian (A : Set (Ell2C →L[ℂ] Ell2C)) : Prop where
  /-- Every atomic projection belongs to the algebra. -/
  atoms_mem : ∀ i : ℕ, atomProj i ∈ A
  /-- The algebra is abelian. -/
  abelian : ∀ S ∈ A, ∀ T ∈ A, S.comp T = T.comp S

/-- **Every purely atomic abelian algebra consists of diagonal operators**, hence
is carried by the injective unital `*`-map `diagOp` from a subalgebra of
`ℓ∞(ℕ)`. -/
theorem atomic_abelian_subset_diagonal {A : Set (Ell2C →L[ℂ] Ell2C)}
    (hA : IsAtomicAbelian A) : A ⊆ Set.range diagOp := by
  intro T hT
  obtain ⟨d, hd⟩ := (commutes_atomProj_iff T).1
    (fun i => hA.abelian T hT (atomProj i) (hA.atoms_mem i))
  exact ⟨d, hd.symm⟩

/-- **Headline (GAP-2 condensation).**  A purely atomic abelian algebra that is
maximal abelian (every operator commuting with all of it already belongs to it) is
*exactly* the diagonal algebra — that is, `*`-isomorphic to `ℓ∞(ℕ)` through the
injective unital `*`-map `diagOp`.  In the purely atomic case the classification
therefore *is* exhaustive: there is nothing but `ℓ∞`. -/
theorem atomic_abelian_maximal_eq_diagonal {A : Set (Ell2C →L[ℂ] Ell2C)}
    (hA : IsAtomicAbelian A)
    (hmax : ∀ T : Ell2C →L[ℂ] Ell2C, (∀ S ∈ A, T.comp S = S.comp T) → T ∈ A) :
    A = Set.range diagOp := by
  refine Set.Subset.antisymm (atomic_abelian_subset_diagonal hA) ?_
  rintro T ⟨d, rfl⟩
  refine hmax _ fun S hS => ?_
  obtain ⟨e, rfl⟩ := atomic_abelian_subset_diagonal hA hS
  exact diagOp_comm d e

/-- The identification is by a faithful unital `*`-map: `diagOp` is injective,
multiplicative, unital, and intertwines the involutions. -/
theorem diagonal_starAlgebra_package :
    Function.Injective diagOp ∧
      (∀ d e : EllInf, diagOp (d * e) = (diagOp d).comp (diagOp e)) ∧
      diagOp (1 : EllInf) = ContinuousLinearMap.id ℂ Ell2C ∧
      (∀ d : EllInf, ∀ f g : Ell2C,
        (inner ℂ (diagOp d f) g : ℂ) = (inner ℂ f (diagOp (star d) g) : ℂ)) :=
  ⟨diagOp_injective, diagOp_mul, diagOp_one, diagOp_star⟩

/-! ## The measure-theoretic side: only two purely atomic classes -/

open MeasureTheory BookProof.ChapterAtomicDecomposition

/-- **There are exactly two purely atomic classes.**  The atom set of a
probability measure is countable, so it is either finite — index type `Fin n`, the
class `Iₙ` — or countably infinite — index type `ℕ`, the class `ℓ∞(ℕ)`.  No third
purely atomic type occurs, which is the measure-theoretic form of the condensation
proved above for operators. -/
theorem atomic_measure_index_dichotomy {X : Type*} [MeasurableSpace X]
    [MeasurableSingletonClass X] (mu : Measure X) [IsProbabilityMeasure mu] :
    (∃ n : ℕ, Nonempty (atoms mu ≃ Fin n)) ∨ Nonempty (atoms mu ≃ ℕ) := by
  have hcount : (atoms mu).Countable := atoms_countable mu
  haveI : Countable (atoms mu) := hcount.to_subtype
  rcases finite_or_infinite (atoms mu) with hfin | hinf
  · exact Or.inl (Finite.exists_equiv_fin (atoms mu))
  · haveI : Encodable (atoms mu) := Encodable.ofCountable _
    exact Or.inr ⟨(Denumerable.ofEncodableOfInfinite (atoms mu)).eqv⟩

end BookProof.ChapterAbelianAtomicCondensation

end
