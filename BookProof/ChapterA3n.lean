import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j

/-!
# Chapter A, §A.3 — Note 51 / Lemma 52: the arbitrary `N`-fold symmetric power

Source: `book.tex` §A.3, Notes 50–51 and Lemma 52 (line ~5560).

`ChapterA3l` (two-fold, `S₂`) and `ChapterA3m` (three-fold, `S₃`) built the
braiding / symmetrizer structure at the first two symmetric tensor powers.  This
file takes the **general step**: for *arbitrary* `N` it formalizes the `N`-fold
tensor product `V^{⊗N}` and the action of the full symmetric group `S_N` by
braidings, culminating in the Lemma-52 payoff that the total symmetrizer
`projSym = (1/N!)·Σ_{σ∈S_N} ρ(σ)` is a genuine projector onto a **full-Lorentz**
subrepresentation (the symmetric power `V^{⊙N}`, carrier of the top irrep
`V⁺_{N/2}`).

## The model

Rather than iterated (left-associated) Kronecker products, we use the clean
`N`-fold tensor model: the carrier is `Matrix (Fin N → Fin 4) (Fin N → Fin 4) ℂ`,
indexed by *tuples* `a : Fin N → Fin 4`.  A family of single-slot operators
`M : Fin N → Matrix (Fin 4) (Fin 4) ℂ` acts as the tensor operator

  `tensorPow M := a b ↦ ∏ i, (M i) (a i) (b i)`  (the `N`-fold `⊗ᵢ Mᵢ`),

which is *multiplicative* (`tensorPow M * tensorPow M' = tensorPow (M·M')`,
`tensorPow_mul`) and unital (`tensorPow_one`) because a sum over tuples of a
product factorises (`Finset.prod_univ_sum`).  A permutation `σ : S_N` acts by the
slot-braiding permutation matrix

  `permMat σ := a b ↦ [b = a ∘ σ]`,

a homomorphism `permMat σ * permMat τ = permMat (σ·τ)` (`permMat_mul`,
`permMat_one`).  The two interact by the **braiding relation**

  `permMat σ * tensorPow M = tensorPow (M ∘ σ⁻¹) * permMat σ`  (`permMat_braiding`).

## The Lemma-52 payoff

* The **diagonal** `Spin⁺` generator `diagGen A := Σᵢ (1⊗…⊗A⊗…⊗1)` and the
  **uniform** parity operator `uniform A := A⊗…⊗A` each commute with every
  `permMat σ` (`permMat_diagGen_comm`, `permMat_uniform_comm`) — the totally
  symmetric diagonal action is invariant under any permutation of the `N` slots.
* Hence the total symmetrizer `projSym N := (N!)⁻¹ • Σ_{σ} permMat σ` is a genuine
  **projector** (`projSym_idem`, encoding `(Σ_σ σ)² = N!·Σ_σ σ`) that commutes
  with `diagGen A` and `uniform A` (`projSym_diagGen_comm`, `projSym_uniform_comm`).
* Specialising `A` to the §A.3 data gives the headline statement: the symmetric
  power is a full-Lorentz subrepresentation, invariant under the diagonal `Spin⁺`
  generators `γ^μγ^ν` (`projSym_spinGenDiag_comm`) **and** under diagonal parity
  `γ⁰⊗…⊗γ⁰` (`projSym_parityDiag_comm`).

Everything is `sorry`-free / `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`), with **no `EXTERNAL` hypothesis** (Note 50 / Weyl complete
reducibility remains the cited backbone).  This generalises the concrete `N = 2`
(`ChapterA3l`) and `N = 3` (`ChapterA3m`) constructions to all `N`.
-/

open Matrix
open scoped BigOperators

namespace BookProof.ChapterA3n

open BookProof.ChapterA3 BookProof.ChapterA3j

/-- The index type of the `N`-fold tensor product: tuples `Fin N → Fin 4`. -/
abbrev Idx (N : ℕ) := Fin N → Fin 4

/-- The `4^N`-dimensional carrier space `V^{⊗N}` of `N` Dirac spinors, modeled as
matrices indexed by tuples `Fin N → Fin 4`. -/
abbrev MN (N : ℕ) := Matrix (Idx N) (Idx N) ℂ

/-- The `N`-fold tensor operator `⊗ᵢ Mᵢ` built from a family of single-slot
operators `M : Fin N → Matrix (Fin 4) (Fin 4) ℂ`:
`(tensorPow M) a b = ∏ i, (M i) (a i) (b i)`. -/
noncomputable def tensorPow {N : ℕ} (M : Fin N → Matrix (Fin 4) (Fin 4) ℂ) : MN N :=
  Matrix.of fun a b => ∏ i, M i (a i) (b i)

/-- The slot-braiding permutation matrix of `σ : S_N`, acting on `V^{⊗N}` by
permuting the tensor factors: `(permMat σ) a b = [b = a ∘ σ]`. -/
noncomputable def permMat {N : ℕ} (σ : Equiv.Perm (Fin N)) : MN N :=
  Matrix.of fun a b => if b = a ∘ σ then (1 : ℂ) else 0

/-- The **diagonal** `Spin⁺` generator built from a single-slot operator `A`:
`diagGen A = Σᵢ (1 ⊗ … ⊗ A ⊗ … ⊗ 1)` with `A` in slot `i`. -/
noncomputable def diagGen {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) : MN N :=
  ∑ i : Fin N, tensorPow (fun j => if j = i then A else 1)

/-- The **uniform** (diagonal-parity type) operator `A ⊗ … ⊗ A`. -/
noncomputable def uniform {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) : MN N :=
  tensorPow (fun _ => A)

/-- The total symmetrizer `projSym N = (N!)⁻¹ • Σ_{σ∈S_N} permMat σ` onto the
symmetric power `V^{⊙N}`. -/
noncomputable def projSym (N : ℕ) : MN N :=
  (Nat.factorial N : ℂ)⁻¹ • ∑ σ : Equiv.Perm (Fin N), permMat σ

/-! ## Multiplicativity of the tensor operator -/

/-
The tensor operator is multiplicative: `(⊗ᵢ Mᵢ)(⊗ᵢ M'ᵢ) = ⊗ᵢ (Mᵢ M'ᵢ)`.
This is the factorisation of a sum over tuples of a product of factors.
-/
theorem tensorPow_mul {N : ℕ} (M M' : Fin N → Matrix (Fin 4) (Fin 4) ℂ) :
    tensorPow M * tensorPow M' = tensorPow (fun i => M i * M' i) := by
  ext a c;
  simp only [tensorPow, mul_apply, of_apply];
  simp only [← Finset.prod_mul_distrib];
  exact Eq.symm (Fintype.prod_sum fun i j ↦ M i (a i) j * M' i j (c i))

/-
The tensor operator of the all-identity family is the identity.
-/
theorem tensorPow_one {N : ℕ} :
    tensorPow (N := N) (fun _ => (1 : Matrix (Fin 4) (Fin 4) ℂ)) = 1 := by
  unfold tensorPow;
  ext a b; simp only [one_apply, of_apply] ;
  by_cases h : a = b <;> simp only [h, ↓reduceIte, Finset.prod_const_one];
  rw [ Finset.prod_eq_zero_iff ] ; contrapose! h ; aesop

/-! ## The permutation representation -/

/-
`permMat` is a homomorphism from `S_N`: `permMat σ * permMat τ = permMat (σ*τ)`.
-/
theorem permMat_mul {N : ℕ} (σ τ : Equiv.Perm (Fin N)) :
    permMat σ * permMat τ = permMat (σ * τ) := by
  ext a c; simp only [mul_apply] ;
  unfold permMat; simp [ Finset.sum_ite ] ;
  rfl

/-
`permMat` sends the identity permutation to the identity matrix.
-/
theorem permMat_one {N : ℕ} : permMat (1 : Equiv.Perm (Fin N)) = 1 := by
  ext a b; simp [permMat, Matrix.one_apply];
  grind

/-! ## The braiding relation -/

/-
**Braiding relation**: conjugating the tensor operator by a permutation
matrix permutes the single-slot operators,
`permMat σ * tensorPow M = tensorPow (fun j => M (σ⁻¹ j)) * permMat σ`.
-/
theorem permMat_braiding {N : ℕ} (σ : Equiv.Perm (Fin N))
    (M : Fin N → Matrix (Fin 4) (Fin 4) ℂ) :
    permMat σ * tensorPow M = tensorPow (fun j => M (σ⁻¹ j)) * permMat σ := by
  ext a c;
  simp only [permMat, tensorPow, mul_apply, of_apply, ite_mul, one_mul, zero_mul,
      Finset.sum_ite_eq', Finset.mem_univ, ↓reduceIte, Function.comp_apply, Equiv.Perm.coe_inv,
          mul_ite, mul_one, mul_zero];
  rw [ Finset.sum_eq_single ( c ∘ σ.symm ) ];
  · conv_rhs => rw [ ← Equiv.prod_comp σ ] ;
    grind;
  · intro b _ hb; contrapose! hb; aesop;
  · exact fun h => False.elim <| h <| Finset.mem_univ _

/-! ## Each permutation commutes with the diagonal action -/

/-
Every braiding commutes with the uniform (diagonal-parity) operator, since
permuting identical factors leaves the tensor unchanged.
-/
theorem permMat_uniform_comm {N : ℕ} (σ : Equiv.Perm (Fin N))
    (A : Matrix (Fin 4) (Fin 4) ℂ) :
    permMat σ * uniform A = uniform A * permMat σ := by
  convert permMat_braiding σ ( fun _ => A ) using 1

/-
Every braiding commutes with the diagonal `Spin⁺` generator, since permuting
the slots merely reindexes the sum `Σᵢ (1⊗…⊗A⊗…⊗1)`.
-/
theorem permMat_diagGen_comm {N : ℕ} (σ : Equiv.Perm (Fin N))
    (A : Matrix (Fin 4) (Fin 4) ℂ) :
    permMat σ * diagGen A = diagGen A * permMat σ := by
  unfold diagGen
  rw [Finset.mul_sum, Finset.sum_mul,
    ← Equiv.sum_comp σ (fun i => tensorPow (fun j => if j = i then A else 1) * permMat σ)]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [permMat_braiding]
  refine congrArg (· * permMat σ) (congrArg tensorPow (funext fun j => ?_))
  simp only [Equiv.Perm.inv_def, Equiv.symm_apply_eq]

/-! ## The total symmetrizer -/

/-
The core group identity `(Σ_{σ∈S_N} σ)² = N!·(Σ_{σ∈S_N} σ)`: multiplying the
group sum by itself and reindexing gives `|S_N| = N!` copies of the group sum.
-/
theorem sum_permMat_sq {N : ℕ} :
    (∑ σ : Equiv.Perm (Fin N), permMat σ) * (∑ σ : Equiv.Perm (Fin N), permMat σ)
      = (Nat.factorial N : ℂ) • ∑ σ : Equiv.Perm (Fin N), permMat σ := by
  have h_sum : ∀ σ : Equiv.Perm (Fin N),
      ∑ τ : Equiv.Perm (Fin N), permMat (σ * τ) = ∑ τ : Equiv.Perm (Fin N), permMat τ :=
    fun σ => Equiv.sum_comp (Equiv.mulLeft σ) fun τ => permMat τ
  convert Finset.sum_congr rfl fun σ _ => h_sum σ using 1
  any_goals exact Finset.univ
  · simp [ Finset.sum_mul _ _ _, Finset.mul_sum, permMat_mul ]
  · simp [ Fintype.card_perm ]
    norm_num [ Algebra.smul_def ]

/-
`projSym N` is idempotent — a genuine projector onto the symmetric power.
-/
theorem projSym_idem {N : ℕ} : projSym N * projSym N = projSym N := by
  have h : (Nat.factorial N : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.factorial_ne_zero N)
  unfold projSym
  rw [Matrix.smul_mul, Matrix.mul_smul, sum_permMat_sq, smul_smul, smul_smul,
    mul_assoc, inv_mul_cancel₀ h, mul_one]

/-
The symmetrizer commutes with the uniform (diagonal-parity) operator.
-/
theorem projSym_uniform_comm {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projSym N * uniform A = uniform A * projSym N := by
  unfold projSym;
  simp only [smul_mul_assoc, mul_smul_comm];
  simp only [Finset.sum_mul, permMat_uniform_comm, Finset.mul_sum _ _ _]

/-
The symmetrizer commutes with the diagonal `Spin⁺` generator.
-/
theorem projSym_diagGen_comm {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projSym N * diagGen A = diagGen A * projSym N := by
  unfold projSym;
  simp only [smul_mul_assoc, mul_smul_comm];
  simp only [Finset.sum_mul, permMat_diagGen_comm, Finset.mul_sum _ _ _]

/-! ## Lemma 52 payoff — the symmetric power is a full-Lorentz subrepresentation -/

/-- **Lemma 52 (general `N`).** The symmetric power is a diagonal `Spin⁺`
subrepresentation: `projSym N` commutes with every diagonal Lorentz generator
`Σᵢ (1⊗…⊗γ^μγ^ν⊗…⊗1)`. -/
theorem projSym_spinGenDiag_comm {N : ℕ} (μ ν : Fin 4) :
    projSym N * diagGen (spinGen μ ν) = diagGen (spinGen μ ν) * projSym N :=
  projSym_diagGen_comm _

/-- **Lemma 52 (general `N`).** The symmetric power is also parity-invariant:
`projSym N` commutes with diagonal parity `γ⁰⊗…⊗γ⁰`.  Thus the real symmetric
power is automatically a representation of the full Lorentz group. -/
theorem projSym_parityDiag_comm {N : ℕ} :
    projSym N * uniform (mgamma 0) = uniform (mgamma 0) * projSym N :=
  projSym_uniform_comm _

end BookProof.ChapterA3n
