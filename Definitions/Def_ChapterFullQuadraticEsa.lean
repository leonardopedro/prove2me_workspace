import Mathlib



/-!
# Chapter A, §A.1 scaffolding — anti-unitary operators and Def 8 structures

This file formalizes the self-contained infrastructure of Chapter A §A.1 of
`book.tex` (see `FORMALIZATION_ROADMAP.md`, work-package **N1**): the notion of an
**anti-unitary** operator (Note 4) and the two **Def 8** structures attached to a
system — a **C-conjugation** on a complex system and an **R-imaginary** operator
on a real system — together with the elementary structural lemmas about them.

An anti-unitary operator on a complex inner-product space is exactly a
conjugate-linear isometric equivalence, i.e. a `LinearIsometryEquiv` whose ring
homomorphism is complex conjugation `starRingEnd ℂ` (`V ≃ₗᵢ⋆[ℂ] V`).  We take
this as the definition of `AntiUnitary V`, so that the whole `LinearIsometryEquiv`
API is available.

The deep §A.1 propositions (Prop 11/12, the R-real/R-pseudoreal/R-complex
trichotomy) require a *complex inner-product* structure on the complexification
`W^c = ℂ ⊗_ℝ W` of a real Hilbert space, which is **not** available in Mathlib and
would have to be built from scratch; that remains an outstanding obstruction
recorded in `BookProof/STATUS.md`.  Everything in this file is `sorry`-free and
`axiom`-free.
-/

open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

namespace BookProof.ChapterA

/-! ## Note 4 / Def 8 — anti-unitary operators -/

/-- **Note 4 (anti-unitary operator).** An anti-unitary operator on a complex
inner-product space `V` is a conjugate-linear (semilinear over `starRingEnd ℂ`)
isometric equivalence of `V`. -/
abbrev AntiUnitary (V : Type*) [NormedAddCommGroup V] [InnerProductSpace ℂ V] :=
  V ≃ₗᵢ⋆[ℂ] V

namespace AntiUnitary

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]

/--
An anti-unitary operator preserves the inner product up to complex
conjugation: `⟪θ x, θ y⟫ = conj ⟪x, y⟫`.
-/
lemma inner_map_map (θ : AntiUnitary V) (x y : V) :
    inner ℂ (θ x) (θ y) = conj (inner ℂ x y) := by
  rw [inner_eq_sum_norm_sq_div_four (𝕜 := ℂ), inner_eq_sum_norm_sq_div_four (𝕜 := ℂ)]
  have hn : ∀ z : V, ‖θ z‖ = ‖z‖ := fun z => θ.norm_map z
  have hI : (RCLike.I : ℂ) • θ y = θ (-(RCLike.I : ℂ) • y) := by
    rw [θ.map_smulₛₗ]; simp
  have e1 : ‖θ x + θ y‖ = ‖x + y‖ := by rw [← map_add, hn]
  have e2 : ‖θ x - θ y‖ = ‖x - y‖ := by rw [← map_sub, hn]
  have e3 : ‖θ x + (RCLike.I : ℂ) • θ y‖ = ‖x - (RCLike.I : ℂ) • y‖ := by
    rw [hI, ← map_add, hn, neg_smul, ← sub_eq_add_neg]
  have e4 : ‖θ x - (RCLike.I : ℂ) • θ y‖ = ‖x + (RCLike.I : ℂ) • y‖ := by
    rw [hI, ← map_sub, hn, neg_smul, sub_neg_eq_add]
  rw [e1, e2, e3, e4, map_div₀]
  apply Complex.ext <;>
    simp [Complex.div_re, Complex.div_im, Complex.add_im, Complex.add_re, Complex.mul_re,
      Complex.mul_im] <;> ring



end AntiUnitary

/-! ## Def 8 — C-conjugation and R-imaginary structures on a system -/

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]



variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]



/-! ### Structural lemmas for a C-conjugation -/









/-! ### Structural lemmas for an R-imaginary operator -/





end BookProof.ChapterA



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





/-- The **uniform** (diagonal-parity type) operator `A ⊗ … ⊗ A`. -/
noncomputable def uniform {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) : MN N :=
  tensorPow (fun _ => A)



/-! ## Multiplicativity of the tensor operator -/

/-
The tensor operator is multiplicative: `(⊗ᵢ Mᵢ)(⊗ᵢ M'ᵢ) = ⊗ᵢ (Mᵢ M'ᵢ)`.
This is the factorisation of a sum over tuples of a product of factors.
-/


/-
The tensor operator of the all-identity family is the identity.
-/


/-! ## The permutation representation -/

/-
`permMat` is a homomorphism from `S_N`: `permMat σ * permMat τ = permMat (σ*τ)`.
-/


/-
`permMat` sends the identity permutation to the identity matrix.
-/


/-! ## The braiding relation -/

/-
**Braiding relation**: conjugating the tensor operator by a permutation
matrix permutes the single-slot operators,
`permMat σ * tensorPow M = tensorPow (fun j => M (σ⁻¹ j)) * permMat σ`.
-/


/-! ## Each permutation commutes with the diagonal action -/

/-
Every braiding commutes with the uniform (diagonal-parity) operator, since
permuting identical factors leaves the tensor unchanged.
-/


/-
Every braiding commutes with the diagonal `Spin⁺` generator, since permuting
the slots merely reindexes the sum `Σᵢ (1⊗…⊗A⊗…⊗1)`.
-/


/-! ## The total symmetrizer -/

/-
The core group identity `(Σ_{σ∈S_N} σ)² = N!·(Σ_{σ∈S_N} σ)`: multiplying the
group sum by itself and reindexing gives `|S_N| = N!` copies of the group sum.
-/


/-
`projSym N` is idempotent — a genuine projector onto the symmetric power.
-/


/-
The symmetrizer commutes with the uniform (diagonal-parity) operator.
-/


/-
The symmetrizer commutes with the diagonal `Spin⁺` generator.
-/


/-! ## Lemma 52 payoff — the symmetric power is a full-Lorentz subrepresentation -/





end BookProof.ChapterA3n



/-!
# The atomic / continuous classification of a probability measure

`BookProof.ChapterSelectingEvents` proves that every probability measure on a
space with measurable singletons splits into a continuous (atomless) part and a
part carried by the countable set of atoms
(`exists_continuous_atomic_decomposition`).  The book's chapter *"Selecting
events is not rewriting the history of events"* uses that splitting to state von
Neumann's classification of abelian von Neumann algebras into **five** types
(`book.tex` lines 8789–8800):

`ℓ∞({1,…,n})`, `ℓ∞(ℕ)`, `L∞([0,1])`, `L∞([0,1] ∪ {1,…,n})`, `L∞([0,1] ∪ ℕ)`.

The full `*`-isomorphism classification is von Neumann's theorem and is not
formalized here.  What *is* formalized is its exact measure-theoretic skeleton,
which is what the book's argument actually uses:

* `atoms_countable` — the set of atoms is countable;
* `atomicPart_eq_sum_dirac` — the atomic part of `μ` is literally a countable
  sum of point masses `∑ₓ μ{x}·δₓ`;
* `noAtoms_continuousPart` — the complementary part is atomless;
* `eq_continuousPart_add_atomicPart` — `μ` is the sum of the two;
* `not_continuousPart_zero_and_atoms_empty` — a probability measure cannot have
  both parts trivial;
* HEADLINE `probability_measure_five_types` — consequently every probability
  measure falls into exactly one of **five** mutually exclusive classes, indexed
  by (continuous part present or not) × (atoms: none / finitely many / countably
  infinitely many), matching the five types of the book's list one for one.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open MeasureTheory

namespace BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

/-- The set of **atoms** of a measure: the points carrying positive mass. -/
def atoms (mu : Measure X) : Set X := {x | 0 < mu {x}}





















end BookProof.ChapterAtomicDecomposition



/-!
# Chapter *"Quantization due to time-evolution: Yang-Mills and Classical Statistical Field Theory"*,
§*"Pure SU(3) Yang-Mills theory"*: nilpotency of the BRST charge

This file formalizes the central algebraic fact behind the book's BRST/gauge
programme (`book.tex` lines ~7050 and ~7343): the **nilpotency of the BRST
charge**

  `Ω(x) = π^μ_a ∂_μ ψ†_a − π^μ_a f_{abc} A_{μ b} ψ†_c − (i/2) f_{abc} ψ†_a ψ†_b ψ_c`,

`Ω² = 0`, which is what makes the BRST cohomology (hence the physical /
gauge-invariant algebra that the book proposes as the definition of Quantum
Yang-Mills) well defined.

We isolate the **cubic ghost term**, the only part whose nilpotency requires the
non-abelian structure of the gauge group, and prove that it squares to zero.
Concretely: in any associative `ℝ`-algebra `R`, given

* ghost creation operators `χ : Fin n → R` (the book's `ψ†_a`) and annihilation
  operators `β : Fin n → R` (the book's `ψ_a`) satisfying the **canonical
  anticommutation relations**
  `{χ_a, χ_b} = 0`, `{β_a, β_b} = 0`, `{β_a, χ_b} = δ_{ab}`, and
* real structure constants `f : Fin n → Fin n → Fin n → ℝ` that are
  **antisymmetric** in their first two indices and satisfy the **Jacobi
  identity** `∑_e (f_{abe} f_{ecg} + f_{bce} f_{eag} + f_{cae} f_{ebg}) = 0`
  (both proved for the SU(N) generators in `ChapterYangMillsSU3.lean`),

the cubic ghost charge

  `Q = ∑_{a,b,e} f_{abe} · (χ_a χ_b β_e)`

satisfies `Q · Q = 0` (`brst_charge_nilpotent`).

The proof normal-orders `Q²`: pushing the middle annihilation operator through
the two creation operators (`beta_move`) splits `Q²` into a **purely quartic**
ghost term that vanishes by fermionic antisymmetry alone (`quartic_term_zero`,
using `chi_swap4`) and two **contracted** terms that combine and vanish by the
Jacobi identity (`contracted_terms_zero`).
-/

namespace BookProof.BRSTNilpotent

variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}



/-- The cubic ghost part of the BRST charge,
`Q = ∑_{a,b,e} f_{abe} · (χ_a · χ_b · β_e)`. -/
noncomputable def Q (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R) : R :=
  ∑ a, ∑ b, ∑ e, f a b e • (χ a * χ b * β e)







/-
**The purely quartic ghost term vanishes.**  The fully normal-ordered piece
of `Q²`, `∑ f_{abe} f_{dgh} · (χ_a χ_b χ_d χ_g β_e β_h)`, is antisymmetric under
exchanging the two `Q`-factors (even sign on the four `χ`'s, odd sign on the two
`β`'s), hence equals its own negative and so is zero.
-/


/-
**The contracted terms vanish by the Jacobi identity.**  The two terms
produced by contracting the middle `β` against the second pair of `χ`'s combine
to `2·∑_{a,b,g,h} (∑_e f_{abe} f_{egh}) · (χ_a χ_b χ_g β_h)`; contracting the
totally-antisymmetric `χ_a χ_b χ_g` against the coefficient antisymmetrizes it,
which is exactly the Jacobi combination and so vanishes.
-/


/-
**Nilpotency of the (cubic) BRST charge, `Q² = 0`.**  Given the ghost
canonical anticommutation relations and structure constants that are
antisymmetric in their first two indices and satisfy the Jacobi identity, the
cubic ghost part of the BRST charge is nilpotent — the property that makes the
BRST cohomology, and hence the book's definition of the gauge-invariant
(physical) algebra of Quantum Yang-Mills, well defined.
-/


end BookProof.BRSTNilpotent



/-!
# Chapter *"On the physical parity transformation and antiparticles"*, §*"Majorana spinors in
canonical quantization and antiparticles"*: the **bosonic** canonical commutation variant

This file formalizes the self-contained algebraic content of the **bosonic**
paragraph of the book section *"Majorana spinors in canonical quantization and
antiparticles"* (`book.tex` line ~7700), the companion of the fermionic
Clifford/CAR construction already formalized in `ChapterMajoranaClifford.lean`.

There the book writes, for the canonical quantization of a **real symplectic
space** `V` (with a complex structure `J`, `J² = -1`, so that
`ω(v,w) = ⟪v, J w⟫` is the symplectic product):

> *"For bosons, we have a similar situation, except that a commutation relation
> holds `[a(v), a(w)] = ⟪v, J w⟫ i` instead of `{a(v), a(w)} = ⟪v, w⟫ 1`; a
> symplectic product `⟪v, J w⟫ i` replaces the inner product `⟪v, w⟫ 1` … The
> operators `a(v) = a(v + iJ v) + a(v − iJ v)` are again self-adjoint and
> represent a particle which is its own antiparticle."*

The Weyl / CCR algebra realizing this has **no finite-dimensional
representation** (the trace of a commutator vanishes while the trace of a nonzero
scalar does not), and Mathlib has no ready-made Weyl algebra, so — exactly as the
`GhostCAR` hypothesis structure of `ChapterBRSTNilpotent.lean` does for the
fermionic ghosts — we package the two book relations as a **hypothesis
structure** `BosonicCCR` on an abstract complex `*`-algebra `R`:

* `selfAdjoint` : each field operator `a(v)` is **self-adjoint**
  (`star (a v) = a v`) — *"a particle which is its own antiparticle"*;
* `ccr` : the **canonical commutation relation**
  `a(v)·a(w) − a(w)·a(v) = (i · ⟪v, J w⟫)·1`.

Here `a : V →ₗ[ℝ] R` is the **real-linear** field map (a real representation), and
`R` is a complex `*`-algebra. From these two relations we derive:

* `symplectic_antisymm` / `symplectic_self` — the symplectic form `ω(v,w) = ⟪v,J w⟫`
  built from a skew `J` is **antisymmetric** and **alternating** (`ω(v,v) = 0`);
* `field_commute_self_scalar` — the CCR scalar for `v = w` **vanishes**, i.e. a
  field operator commutes with itself (consistency with `ω(v,v) = 0`);
* `commutator_antiSelfAdjoint` — the commutator `[a(v),a(w)]` is
  **anti-self-adjoint**, which is exactly the self-adjointness constraint on
  `i·ω(v,w)·1` (a real multiple of `i` is anti-self-adjoint);
* `field_comp_selfAdjoint` — **real representations preserve self-adjointness**:
  for *any* real-linear `T : V → V`, `a(T v)` is again self-adjoint
  (the book's `a(v) → a(T v)` with `T` a real operator);
* `ccr_symplectic_invariant` — a **symplectic symmetry** `T` (one preserving
  `ω`) transports the CCR unchanged: `a ∘ T` satisfies the same commutation
  relation;
* `ann` / `cre`, `star_ann` / `star_cre` — the **creation/annihilation split**
  `a(v ± iJv)`: the involution `*` **swaps** annihilation and creation
  (`star (ann v) = cre v`), and `ann_add_cre` recovers the self-adjoint field
  `ann v + cre v = a v + a v`;
* `commutator_field_Jfield` — `[a(v), a(J v)] = -(i · ‖v‖²)·1` (using `J² = -1`);
* `commutator_cre_ann` — the resulting **number-operator CCR**
  `[c(v), a(v)] = (2‖v‖²)·1`, the bosonic analogue of `[a, a†] = 1`.

The C\*-completion (the natural norm) is prose in the book and is not formalized.
-/

open RealInnerProductSpace

namespace BookProof.Bosonic

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]



variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}













/-- The **annihilation** operator `a(v + iJ v) = a(v) + i·a(J v)`. -/
noncomputable def ann (a : V →ₗ[ℝ] R) (J : V →ₗ[ℝ] V) (v : V) : R :=
  a v + Complex.I • a (J v)

/-- The **creation** operator `a(v − iJ v) = a(v) − i·a(J v)`. -/
noncomputable def cre (a : V →ₗ[ℝ] R) (J : V →ₗ[ℝ] V) (v : V) : R :=
  a v - Complex.I • a (J v)













end BookProof.Bosonic



/-!
# BRST leakage under Krylov truncation: a quantitative bound

`CONSOLIDATED_PLAN.md` §12.2 **Gap 5** ("the physical-subspace (BRST) leakage") records
what is missing: the truncated dynamics the SIRK/Hashimoto solver actually integrates does
*not* preserve the physical subspace — the numerics document growth of the BRST-charge
content `‖Ω ψ(t)‖` under aggressive truncation, which is why the solver rides a BRST
projector along — and no formal bound on that leakage in terms of the truncation exists.
`BookProof.ChapterBRSTNilpotent` supplies the algebraic side (`Ω² = 0`, `[H, Ω] = 0`); this
module supplies the analytic side.

## What is new here

`BookProof.ChapterSirkRestart.brst_leakage_bound` already bounds the leakage of `n` cycles of
a truncated *propagator* `S` by `‖Ω‖ n ε ‖v‖` — but with the per-cycle closeness `ε` of `S`
to the exact propagator as a *hypothesis*, so nothing there ties the leakage to the
truncation itself.  This module works one level down, at the generators the algorithm
actually truncates, and produces `ε` rather than assuming it: the leakage rate is the norm
of the block of the Hamiltonian that the truncation discards.  The bridge back is
`brst_leakage_bound_of_generator`.

## The statement

Everything is at the level of *bounded* generators — the finite-`m` reduced generators the
algorithm exponentiates, and any bounded model Hamiltonian — on a complex Hilbert space `E`.
For a self-adjoint `A` the flow is `flow A t = exp (t • (-i A))`, a unitary group
(`flow_mem_unitary`, `norm_flow_apply`).

* **Exact dynamics does not leak.**  If `Ω` commutes with `H` then `Ω` is carried along the
  flow, `omega_flow_apply`, so `‖Ω (flow H t x)‖ = ‖Ω x‖` (`norm_omega_flow_eq`) and the
  physical subspace `ker Ω` is invariant (`flow_mem_ker_omega`).
* **The Duhamel estimate.**  `norm_flow_sub_flow_apply_le`: if `‖(A − B)(flow B s x)‖ ≤ K`
  along the `B`-orbit for `s ∈ [0, t]`, then `‖flow B t x − flow A t x‖ ≤ K t`.  The proof
  is the derivative of `s ↦ flow A (t − s) (flow B s x)` (`hasDerivAt_duhamel`) together
  with the mean-value inequality; unitarity of the two groups is what makes the derivative
  bound `K` and not `K e^{c t}`.
* **The sharp transfer rate.**  `norm_flow_sub_flow_le`: in operator norm,
  `‖e^{-itA} − e^{-itB}‖ ≤ ‖A − B‖ t` for self-adjoint bounded generators — the rate that
  `BookProof.ChapterSirkGroupTransfer` records as not claimed there, its telescoping
  estimate carrying an extra factor `e^{|t| M}` (which it needs, being valid for arbitrary
  bounded generators).
* **The leakage bound.**  `leakage_le`: for the truncated flow `ψ(t) = flow B t x`,

  `‖Ω ψ(t)‖ ≤ ‖Ω x‖ + ‖Ω‖ K t`,

  and `leakage_le_of_physical` for a physical initial state (`Ω x = 0`): the leakage grows
  at most linearly in `t`, with slope `‖Ω‖ K`.
* **The truncation instance.**  For an orthogonal projection `P` (idempotent and
  self-adjoint) the truncated generator is `truncGen P H = P H P`; the flow of the truncated
  generator keeps a state inside the retained subspace (`flow_truncGen_mem`, proved by an ODE
  uniqueness argument, not by a series manipulation), so the constant `K` is the
  *off-diagonal block* `‖(1 − P) H P‖ ‖x‖` and not the crude `‖H − P H P‖ ‖x‖`:
  **`truncation_leakage_le`**

  `‖Ω (flow (P H P) t x)‖ ≤ ‖Ω x‖ + ‖Ω‖ ‖(1 − P) H P‖ ‖x‖ t`   (`P x = x`).

  In particular a state that is physical and retained leaks at most
  `‖Ω‖ ‖(1 − P) H P‖ ‖x‖ t` (`truncation_leakage_le_of_physical`): the leakage is controlled
  by the part of the Hamiltonian that the truncation discards, and vanishes with it.
* **Both time directions.**  The bounds above are stated for `t ≥ 0`; when the defect is
  bounded along the whole orbit they hold for every real `t` with `t` replaced by `|t|`
  (`norm_flow_sub_flow_apply_le_abs`, `leakage_le_abs`, `truncation_leakage_le_abs`), by
  reflecting the generators.
* **Restarts.**  The numerics restarts the Krylov cycle, with a *new* truncation each cycle
  (§12.2 Gap 4a).  `leakageIter` is the restarted state after `n` cycles of length `τ` with
  truncated generators `B 0, B 1, …`, and **`leakage_iterate_le`** accumulates the bound
  linearly in the number of cycles:

  `‖Ω (leakageIter B τ x n)‖ ≤ ‖Ω x‖ + n ‖Ω‖ K τ ‖x‖`  whenever `‖H − B i‖ ≤ K`.

## Honest boundary

The generators here are bounded operators: this is the finite-`m` reduced problem and any
bounded model, not the unbounded field-theoretic Hamiltonian, for which the same estimate
needs the Duhamel argument in the strong-resolvent form of `ChapterSirkTrotterKato`.  `Ω` is
an arbitrary bounded operator commuting with `H`; nilpotency `Ω² = 0` — the BRST content of
`ChapterBRSTNilpotent` — is not needed for the leakage bound and is therefore not assumed.
No floating-point analysis (§12.2 Gap 6) is claimed.
-/

open NormedSpace

namespace BookProof.BrstLeakage

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-! ## The unitary group of a bounded self-adjoint generator -/

/-- The flow `e^{-i t A}` of a bounded generator `A`. -/
noncomputable def flow (A : E →L[ℂ] E) (t : ℝ) : E →L[ℂ] E := exp (t • ((-Complex.I) • A))











/-! ## Exact dynamics carries a commuting observable along -/







/-! ## The Duhamel estimate -/













/-! ## The leakage bound -/







/-! ## The truncation instance -/













/-! ## Restarts -/











/-! ## The bridge to the discrete restart estimate

`BookProof.ChapterSirkRestart.brst_leakage_bound` bounds the leakage of `n` cycles of a
truncated *propagator* `S` by `‖Ω‖ n ε ‖v‖`, with the per-cycle closeness `ε` of `S` to the
exact propagator `U` as a hypothesis.  For propagators generated by bounded generators the
Duhamel estimate discharges that hypothesis, with `ε = ‖H − B‖ τ`. -/





end BookProof.BrstLeakage



/-!
# A Carleman criterion for general lattice hops

`BookProof.ChapterHermiteCarlemanEsa` and `BookProof.ChapterCarlemanTwoStep` prove
Carleman (flux) criteria for recursions whose hops move a **single** excitation number,
by one or by two.  That covers every **mode-diagonal** quadratic Hamiltonian.  A quadratic
Hamiltonian which couples two *distinct* modes — `xᵢxⱼ`, `πᵢπⱼ`, `xᵢπⱼ` with `i ≠ j` —
produces hops `α ↦ α ± (eᵢ + eⱼ)` and `α ↦ α ± (eᵢ − eⱼ)`, and the second kind is **not**
monotone: the shift lowers one coordinate while raising another.

This module runs the flux argument for a hop of the completely general shape
`α ↦ α + p − m` (`hshift`), with `p` and `m` multi-indices.

## What is proved

* `hshift`, `hshift_hshift` — the shift and its inverse on the set where it is defined.
* `rtG`, `ltG`, `hopB`, `sum_ltG`, `sum_hop_im` — **the abstract flux cancellation.**  For
  a Hermitian hop family, the contributions from pairs `α, α + p − m` which both lie in a
  finite set `A` cancel in the imaginary part, so the imaginary part of the total is
  carried by two boundary layers: the *outgoing* layer `A \ B` (points of `A` whose image
  leaves `A`) and the *incoming* layer `B \ A` (points outside `A` whose image lands in
  `A`).  For a monotone hop (`m = 0`) the incoming layer is empty and this specialises to
  the situation of the two earlier modules.
-/

namespace BookProof.CarlemanGeneralHop

open Finset

noncomputable section

variable {d : ℕ}

/-! ## 1. The general shift -/

/-- The lattice hop `α ↦ α + p − m` (truncated subtraction; it is used only where
`m ≤ α`). -/
def hshift (p m a : Fin d →₀ ℕ) : Fin d →₀ ℕ := a + p - m







/-! ## 2. The abstract flux cancellation -/

variable {u : (Fin d →₀ ℕ) → ℂ}















/-! ## 3. The boundary layers of a cube -/













/-! ## 4. The flux bound -/



/-! ## 5. Bessel's inequality for the two boundary layers -/

















/-! ## 6. The recursion and the criterion -/



variable {ι : Type*} [Fintype ι] {lam : (Fin d →₀ ℕ) → ℝ} {p m : ι → (Fin d →₀ ℕ)}
  {c c' : ι → (Fin d →₀ ℕ) → ℝ} {w : ι → ℂ} {z : ℂ}





end

end BookProof.CarlemanGeneralHop



/-!
# A Carleman criterion on simplex shells: hops which couple distinct modes

`BookProof.ChapterHermiteCarlemanEsa` and `BookProof.ChapterCarlemanTwoStep` run the
Carleman flux argument on **cubes** `{α : ∀ i, αᵢ ≤ N}`, for hops which move a *single*
excitation number: `α ↦ α ± eᵢ` and `α ↦ α ± 2eᵢ`.  That is exactly the ladder structure
of a quadratic Hamiltonian which does not couple distinct modes.

A general real quadratic Hamiltonian does couple them: `xᵢxⱼ`, `πᵢπⱼ` and `xᵢπⱼ` with
`i ≠ j` produce the hops `α ↦ α ± (eᵢ + eⱼ)` and `α ↦ α + eᵢ − eⱼ`.  On a cube the
bookkeeping of such hops is awkward — a hop leaves a cube through *two* faces at once,
and the mixed hop `α ↦ α + eᵢ − eⱼ` leaves it through one face while entering through
another.

This module reruns the argument on the **simplex shells** `{α : |α| ≤ N}`, where
`|α| = ∑ᵢ αᵢ` is the total degree.  The exhaustion is adapted to the grading by total
excitation number, and everything becomes uniform:

* a hop which *raises* the total degree by `k` (`α ↦ α + P` with `|P| = k`) leaks only
  through the shell `{N − k < |α| ≤ N}`, which meets at most `k` of the shells;
* a hop which *preserves* the total degree (`α ↦ α + eᵢ − eⱼ`) never leaves a shell, so
  it contributes **nothing at all** to the flux: the corresponding sum over a shell is
  real as soon as its amplitude matrix is Hermitian.

## What is proved

* `deg`, `simplexF`, `sInn`, `sBd` — the total degree, the simplex shells and their
  interiors and boundaries.
* `sum_simplex_hop_im` — **the abstract flux cancellation** for a hop `α ↦ α + P` of an
  arbitrary shift `P`: the interior contributions occur in conjugate pairs, so only the
  boundary shell contributes to the imaginary part.
* `sum_mterm_im` — **the degree-preserving hops carry no flux**: for a Hermitian
  amplitude matrix the total contribution of the hops `α ↦ α + eᵢ − eⱼ` over a shell is
  real.
* `LadderRecQ`, `flux_identityQ` — the recursion of a *general* quadratic ladder — one
  step, two steps, pair creation/annihilation and mode exchange — and its flux identity.
* `flux_bound_on`, `sBd_multiplicity`, `shifted_sBd_multiplicity` — the flux bound and
  the summability of the boundary mass (each index lies in at most `k` boundary shells).
* `ladderQ_eq_zero` — **the criterion.**  A square-summable family satisfying the general
  quadratic recursion, with a real diagonal, constant amplitudes and a Hermitian exchange
  matrix, at a point off the real axis, vanishes.  The Carleman divergence used is
  `∑ 1/(N+2) = ∞`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.CarlemanSimplex

open Finset

noncomputable section

variable {d : ℕ}

/-! ## 1. The simplex shells -/

/-- The total degree `|α| = ∑ᵢ αᵢ` of a multi-index. -/
def deg (a : Fin d →₀ ℕ) : ℕ := ∑ i, a i



























/-! ## 2. The abstract flux cancellation for a raising hop -/

variable {u : (Fin d →₀ ℕ) → ℂ}











/-! ## 3. The degree-preserving hops carry no flux -/

/-- The mode-exchange hop `α ↦ α − eⱼ + eᵢ`. -/
def shiftm (a : Fin d →₀ ℕ) (i j : Fin d) : Fin d →₀ ℕ :=
  a - Finsupp.single j 1 + Finsupp.single i 1

/-- The amplitude of the mode-exchange hop: `√(αⱼ(αᵢ+1))` for `i ≠ j`, and the number
`αᵢ` for `i = j`. -/
def rcm (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a j : ℝ)) * Real.sqrt ((((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1)

















/-! ## 4. The general quadratic recursion -/

/-- The shift of the pair hop `(i, j)`: `eᵢ + eⱼ`. -/
def pvec (i j : Fin d) : Fin d →₀ ℕ := Finsupp.single i 1 + Finsupp.single j 1



/-- The raising amplitude of the pair hop: `√((αᵢ+1)(αⱼ+1))` for `i ≠ j`, and
`√((αᵢ+1)(αᵢ+2))` for `i = j`. -/
def rcp (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a j : ℝ) + 1) * Real.sqrt ((((a + Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1)

/-- The lowering amplitude of the pair hop: `√(αᵢαⱼ)` for `i ≠ j`, and `√(αᵢ(αᵢ−1))` for
`i = j`. -/
def lcp (a : Fin d →₀ ℕ) (i j : Fin d) : ℝ :=
  Real.sqrt ((a i : ℝ)) * Real.sqrt ((((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ))









variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}





/-! ## 5. The flux bound and the boundary mass -/













/-! ## 6. The criterion -/



end

end BookProof.CarlemanSimplex



/-!
# The dynamics-based ("less arbitrary") unitary

Source: the manuscript's field-theoretic thread (`QFM.tex`) and the
`ConditionalUnitary` chapter's *"A Less Arbitrary Construction"* section
(`Book/ConditionalUnitary.lean`); proof plan appendix §E
(`Book/ProofPlans.lean`).

`BookProof.ChapterJointUnitary` builds the unitary parametrizing a conditional
probability by *Gram–Schmidt completion* of the wave-function `Ψ = √p`.  That
construction is correct but arbitrary: the columns after the first are chosen by
the completion.  The alternative developed here fixes the unitary by the
*dynamics*: a velocity field `v` on a finite (cyclic) lattice determines a
Weyl-symmetrized Hermitian generator

  `H = ½ (p·v + v·p)`,

and hence a one-parameter unitary group `U t = exp (i t H)`.  The conditional
probability is then recovered by the ordinary Born rule.

We work on the finite lattice `ZMod N` (the discretization used throughout
`BookProof`), with the symmetric-difference momentum
`(p ψ) k = -(i/2) (ψ (k+1) - ψ (k-1))`.

Main results:

* `momentum_hermitian`, `velocityOp_hermitian`,
  `continuityHamiltonian_hermitian` — the Weyl-symmetrized generator is
  Hermitian, while `momentum_mul_velocityOp_not_hermitian` shows the
  unsymmetrized `p·v` is not — the symmetrization is what makes the generator a
  legitimate observable;
* `continuityUnitary_unitary` — `U t = exp (i t H)` is unitary, together with
  `continuityUnitary_zero` and `continuityUnitary_add` (a one-parameter group);
* `bornRecover_nonneg`, `bornRecover_empty`, `bornRecover_union`,
  `bornRecover_univ` — the Born rule applied to the evolved state defines a
  finitely additive probability law on the lattice, for each input;
* `bornPMF` / `condProb_of_continuity` — the capstone: for a family of velocity
  fields indexed by the inputs `x` and a normalized initial state, the Born
  weights form a genuine probability distribution for every `x` (a Markov
  kernel / regular conditional probability in the finite setting), whose mass on
  a set `B` is exactly `bornRecover`;
* `tensorIsom` / `tensorIsom_tmul` — the finite index-level tensor–product
  identification `L²(X) ⊗ L²(Z) ≅ L²(X × Z)` that lets the construction run on
  the scalar space with no Bochner machinery, and
  `bornRecover_product_state` — the Born recovery for a product initial state
  `Ψ₀(x, z) = f(x) e₀(z)` with `|f x| = 1`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators Matrix TensorProduct

namespace BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]

/-! ## The Weyl-symmetrized continuity generator -/

/-- The discrete momentum operator on the cyclic lattice `ZMod N`:
`(p ψ) k = -(i/2) (ψ (k+1) - ψ (k-1))`. -/
noncomputable def momentum (N : ℕ) [NeZero N] : Matrix (ZMod N) (ZMod N) ℂ :=
  fun k j => (if j = k + 1 then -Complex.I / 2 else 0)
           + (if j = k - 1 then Complex.I / 2 else 0)













/-! ## The unitary generated by a Hermitian matrix -/











/-! ## Born recovery of the conditional law -/





















/-! ## The capstone: a conditional probability from the dynamics -/

variable {X : Type*}



/-! ## The finite tensor–product identification `L²(X) ⊗ L²(Z) ≅ L²(X × Z)` -/











end BookProof.ChapterContinuityUnitary



/-!
# Chapter F4 — QFM: tomographic recovery (roadmap N14, §0 S7)

This file formalizes the tomographic-recovery half of the QFM (Quantum Flow
Matching) package (source `RiemannProof/QFM.tex` §8; reference implementation
`../unfer/qfm/`), following the N14 work-package queue (deliverables
F3.1–F3.5).  The F2.x half of N14 is on disk in
`ChapterF3.lean`/`ChapterF5.lean`/`ChapterF7.lean`.

It is the **merge (2026-07-08) of two independent Aristotle formalizations**
of the same deliverables; both are kept in full, in two sections below.

## Deliverables — first formalization (finite uniform-sign model)

* **F3.1 — Count-Sketch linearity and unbiasedness** (§8, `S₁`;
  `qfm/src/sketch.rs`).  The sketch `S₁` is linear (`csketch_add`,
  `csketch_smul`); with Rademacher signs it preserves inner products in
  expectation over the `2^d` sign patterns, `E[⟪S₁ x, S₁ y⟫] = ⟪x, y⟫`
  (`countsketch_unbiased`), via the pairwise sign identity
  `sign_pair_expectation`.
* **F3.2 — observable-matrix identity** (§8, `W_prob`; `qfm/src/observables.rs`).
  `Tr(E_{r,s}ᴴ Wᴴ Pₐ W) = conj(W_{a,r})·W_{a,s}` (`observable_matrix_identity`).
* **F3.3 — the unitary reduced flow** (§8 Phase 2; `qfm/src/potential.rs`).
  A unitary matrix preserves the Hermitian dot product
  (`unitary_preserves_dotProduct`); `e^{i H}` of a self-adjoint `H` is unitary
  (`selfAdjoint_exp_star_mul_self`).
* **F3.4 — the pseudo-inverse left-inverse** (§8, `Φ̃⁺`).  For full-column-rank
  `Φ`, `Φ⁺ = (Φᴴ Φ)⁻¹ Φᴴ` satisfies `Φ⁺ Φ = I` (`pseudoinverse_left_inverse`).

## Deliverables — second formalization (measure-theoretic model) + F3.5

* **F3.1** — Count-Sketch over an abstract probability space: linearity
  (`countSketch_add`) and unbiasedness `E[⟪S₁ x, S₁ y⟫] = ⟪x, y⟫` from the
  Rademacher hypothesis `∫ s c · s c' = δ_{cc'}` (`countSketch_unbiased`).
* **F3.2** — `Tr(E_{r,s}ᴴ Wᴴ Pₐ W) = conj(W_{a,r})·W_{a,s}`
  (`observable_matrix_entry`).
* **F3.3** — for Hermitian `H`, `e^{-i t H}` is unitary
  (`hermitian_flow_unitary`), hence norm-preserving
  (`hermitian_flow_preserves_normSq`).
* **F3.4** — Moore–Penrose left inverse via `Invertible (ΦᵀΦ)`
  (`pseudoInverse_left_inverse`).
* **F3.5 — the Misra–Gries heavy-hitter bound** (§8 Phase 4): with `k`
  counters, the estimate `f̂` of any item in a stream of length `N` satisfies
  `f − N/k ≤ f̂ ≤ f` (`misraGries_bound`; state machine `mgStep`/`mgRun`,
  conservation invariant `mgRun_sum`).  An independent formalization of F3.5
  also lives in `ChapterF6.lean` (`misra_gries_bound`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis, no `axiom`**.
-/

open scoped BigOperators Matrix

namespace BookProof.ChapterF4

/-! ### First formalization — finite uniform-sign model -/

noncomputable section
open Matrix

/-! ## F3.1 — Count-Sketch linearity and unbiasedness (`qfm/src/sketch.rs`) -/





variable {d k : ℕ}



/-
**F3.1** (linearity in the data): `S₁ (x + y) = S₁ x + S₁ y`.
-/


/-
**F3.1** (homogeneity in the data): `S₁ (a • x) = a • S₁ x`.
-/


/-- The uniform expectation over the `2^d` sign patterns `ω : Fin d → Bool`. -/
def expectation (f : (Fin d → Bool) → ℝ) : ℝ := (∑ ω, f ω) / (2 ^ d)

/-
**F3.1** (pairwise sign identity — the independence input): summing
`s(c)·s(c')` over all `2^d` sign patterns gives `2^d` if `c = c'` and `0`
otherwise (Rademacher signs are orthonormal in expectation).
-/


/-
**F3.1** (unbiasedness): `E[⟪S₁ x, S₁ y⟫] = ⟪x, y⟫` — the Count-Sketch
estimator is unbiased for the inner product.
-/


/-! ## F3.2 — the observable-matrix identity (`qfm/src/observables.rs`) -/

/-
**F3.2**: with one-hot projector `Pₐ = |a⟩⟨a|` (`Matrix.single a a 1`) and the
Krylov operator basis element `E_{r,s} = |e_r⟩⟨e_s|` (`Matrix.single r s 1`), the
probability-observable matrix entry is
`Tr(E_{r,s}ᴴ · Wᴴ · Pₐ · W) = conj(W_{a,r})·W_{a,s}`.
-/


/-! ## F3.3 — the unitary reduced flow (`qfm/src/potential.rs`) -/

/-
**F3.3** (inner-product preservation): a unitary matrix `U` (with `Uᴴ U = 1`)
preserves the Hermitian dot product `⟪x, y⟫ = star x ⬝ᵥ y`.  In particular
`‖U x‖ = ‖x‖` (take `y = x`): norm-preserving generation.
-/


variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]

/-
**F3.3** (the generator is unitary): for a self-adjoint `H`, the flow
`e^{i H} = selfAdjoint.expUnitary H` is unitary: `star U · U = 1`.
-/


/-! ## F3.4 — the pseudo-inverse left-inverse -/

/-
**F3.4**: for a full-column-rank matrix `Φ` (so the Gram matrix `Φᴴ Φ` is
invertible), the Moore–Penrose pseudo-inverse `Φ⁺ = (Φᴴ Φ)⁻¹ Φᴴ` is a left
inverse, `Φ⁺ Φ = I` — the subspace-recovery guarantee.
-/



end

/-! ### Second formalization — measure-theoretic model, and F3.5 -/

noncomputable section
open MeasureTheory

/-! ## F3.1 — Count-Sketch linearity and unbiasedness -/

variable {α κ Ω : Type*} [Fintype α] [DecidableEq α] [Fintype κ] [DecidableEq κ]
  {mΩ : MeasurableSpace Ω}





/-
**F3.1** (unbiasedness): with Rademacher signs (`E[s(c) s(c')] = δ_{cc'}`), the
Count-Sketch estimator preserves inner products in expectation:
`E[⟪S₁ x, S₁ y⟫] = ⟪x, y⟫`.  The AMS/Count-Sketch estimator.
-/


/-! ## F3.2 — the observable-matrix identities -/

/-
**F3.2** (observable-matrix entry, outer-product-of-a-row identity): with the
one-hot projector `P_a = |a⟩⟨a|` and operator basis `E_{r,s} = |e_r⟩⟨e_s|`,
`Tr(E_{r,s}ᴴ Wᴴ P_a W) = conj(W_{a,r}) · W_{a,s}`.
-/


/-! ## F3.3 — the unitary reduced flow -/

/-
**F3.3** (unitary reduced flow): for a Hermitian matrix `H`, the reduced flow
`U = e^{-i t H}` is unitary, `Uᴴ * U = 1`.
-/


/-
**F3.3** (norm-preserving generation): the reduced flow `U = e^{-i t H}` of a
Hermitian generator preserves the ℓ² norm-squared of any state,
`‖U c₀‖² = ‖c₀‖²` (the rev-14 `preserves_norm` guarantee).
-/


/-! ## F3.4 — the pseudo-inverse left-inverse -/

/-
**F3.4** (subspace-recovery guarantee): for a full-column-rank matrix `Φ` (so
that the Gram matrix `ΦᵀΦ` is invertible), the Moore–Penrose pseudo-inverse
`Φ⁺ = (ΦᵀΦ)⁻¹Φᵀ` is a left inverse: `Φ⁺ Φ = I`.
-/


/-! ## F3.5 — the Misra–Gries heavy-hitter bound -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]









/-
One-step preservation of the invariant "at most `k` counters are active".
-/


/-
Invariant: at most `k` counters are ever active.
-/


/-
Master conservation invariant: the total counter mass plus `(k+1)` per
decrement round equals the stream length `N`.
-/


/-
Decrement budget: `k · d ≤ N`.
-/


/-
Undercounting: the estimate never exceeds the true frequency.
-/


/-
The estimation error is bounded by the number of decrement rounds.
-/


/-
**F3.5** (Misra–Gries heavy-hitter guarantee): with `k` counters, the
frequency estimate `f̂ x = (mgRun k xs).1 x` of any item `x` in a stream `xs`
of length `N = xs.length` satisfies `f - N/k ≤ f̂ ≤ f`, where `f = xs.count x`
is the true frequency.  The lower bound is stated in the equivalent
truncated-subtraction-free form `f ≤ f̂ + N/k`.
-/



end

end BookProof.ChapterF4



/-!
# Chapter F7 — Quantum Flow Matching: the concrete `x̂` / `p̂` model (roadmap N14, §4)

This file supplies the concrete function-space realization underlying the
algebraic Hermiticity cores of `ChapterF5.lean` (deliverables **F2.1** and
**F2.2** of the *Quantum Flow Matching* package; source `RiemannProof/QFM.tex`
§4, eqs. (4.2)–(4.6); reference implementation `../unfer/qfm/`).  It follows
§0 S7 of the roadmap (the Mehler/Kopperman generative flow).

The state space is the Schwartz space `𝓢(ℝ, ℂ)` with the (sesquilinear) `L²`
pairing `⟪f, g⟫ = ∫ conj (f x) · g x`.  On this dense domain the two elementary
observables of eq. (4.2) are:

* **position** `(x̂ Ψ)(x) = x · Ψ(x)` — multiplication by the real coordinate;
* **momentum** `(p̂ Ψ)(x) = −i Ψ′(x)` — the derivative operator.

## Deliverables

* `l2pair` — the `L²` pairing, together with its (conjugate-)bilinearity
  (`l2pair_add_left/right`, `l2pair_sub_left/right`, `l2pair_smul_left/right`)
  and the integrability helper `l2pair_integrable`.
* `IsL2Symmetric` — symmetry of an operator w.r.t. `l2pair`.
* **position is symmetric** (`position_l2Symmetric`), and more generally
  multiplication by any real function of temperate growth — the concrete
  velocity/potential operator `v(x̂)` — is symmetric (`mulOp_l2Symmetric`).
* **momentum is symmetric** (`momentum_l2Symmetric`), the concrete
  integration-by-parts fact `schwartz_integration_by_parts` (`∫ f′ g = −∫ f g′`
  for Schwartz `f, g`, boundary terms vanishing).
* **F2.1 concretely** (§4 eq. 4.2): the symmetrized product of two symmetric
  operators is symmetric (`anticomm_l2Symmetric`), hence the continuity
  Hamiltonian `H = ½(p̂ v(x̂) + v(x̂) p̂)` is Hermitian
  (`continuityHamiltonian_l2Symmetric`).
* **F2.2 concretely** (§4 eqs. 4.4–4.6): `i·[K, V]` is symmetric when `K, V`
  are (`i_comm_l2Symmetric`); with `K = ½ p̂·p̂` (`kinetic_l2Symmetric`) this is
  the conservative continuity Hamiltonian `H^c = i[K, V(x̂)]`
  (`conservativeHamiltonian_l2Symmetric`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.  Cites `../unfer` crate
`qfm/src/potential.rs` (the Hermitian continuity generator).
-/

open SchwartzMap MeasureTheory Complex
open scoped BigOperators

namespace BookProof.ChapterF7

noncomputable section

/-! ## The `L²` pairing -/



















/-! ## Position and, more generally, real multiplication operators -/

/-- Multiplication by a real function `v` of temperate growth — the concrete
velocity/potential operator `v(x̂)`, `(v(x̂) Ψ)(x) = v(x) · Ψ(x)`. -/
def mulOp (v : ℝ → ℝ) (hv : Function.HasTemperateGrowth (fun x => (v x : ℂ))) :
    𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  SchwartzMap.bilinLeftCLM (ContinuousLinearMap.mul ℂ ℂ) hv









/-! ## Momentum and integration by parts -/



/-- The momentum operator `(p̂ Ψ)(x) = −i Ψ′(x)`. -/
def momentum : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  (-Complex.I) • SchwartzMap.derivCLM ℂ ℂ





/-! ## F2.1 and F2.2 concretely -/









/-- The kinetic operator `K = ½ p̂·p̂`, `(K Ψ)(x) = −½ Ψ″(x)`. -/
def kinetic : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  ((1 : ℂ) / 2) • momentum.comp momentum





end

end BookProof.ChapterF7



/-!
# Chapter F8 — Tomographic Subspace Recovery: the offline compilation
(plan Part F.3, roadmap §10)

`QFM.tex` §10 describes the *Tomographic Subspace Recovery* pipeline.  Its
offline stage compiles the raw corpus into two objects that the online stage then
uses without ever touching the corpus again:

* a **two-level sketch** `S₂ ∘ S₁`, where `S₁ : ℝ^d → ℝ^k` hashes raw coordinates
  into `k ≪ d` features and `S₂ : ℝ^k → Fock(K₂)` places the features on `k`
  distinct modes of a `K₂`-mode Fock space (`K₂ > k`), producing a
  **single-excitation** state; and
* an **operator basis** of the reduced `m`-dimensional Krylov space, consisting
  of `m²` matrix units, into which all raw-coordinate observables are
  pre-projected.

The point of the construction is a cost statement: the corpus size `M` occurs
only in the offline stage, so the online cost carries **no** `M` term.

## Deliverables

* `featureHash` (`S₁`) and `fockEmbed` (`S₂`), `singleExcitation` — the
  single-excitation subspace of the `K₂`-mode Fock space;
* `fockEmbed_mem_singleExcitation`, `twoLevelHash_total` — `S₂ ∘ S₁` is a
  well-defined map of *every* raw vector into the single-excitation subspace;
* `featureHash_decodes` — the sketch is lossless on the feature layer: reading
  the mode `g j` of `S₂ y` returns the feature `y j` (for an injective mode
  assignment `g`), and `twoLevelHash_decodes` composes this with `S₁`;
* `offline_operatorBasis` — the `m²` pre-projected matrix units span the whole
  operator space `Hom(ℂ^m, ℂ^m)`, so the offline basis is complete;
* `online_cost_independent_of_M` — the corpus size enters only through the
  offline term: changing `M` changes the total cost exactly by the change of the
  offline cost;
* `tsr_offline_compiles` — **headline**: the offline stage produces the sketched
  single-excitation embedding *and* a complete `m²` operator basis, and the
  online cost is `M`-free.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open scoped BigOperators

namespace BookProof.ChapterF8

/-! ## The two-level sketch -/

/-- Occupation vectors of a `K`-mode bosonic Fock space. -/
abbrev Occ (K : ℕ) := Fin K →₀ ℕ



















/-! ## The offline operator basis -/







/-! ## The cost split -/













end BookProof.ChapterF8

end



/-!
# Chapter G — Gauge transformations in probability spaces

This file formalizes the self-contained mathematical backbone of the book's
chapter *"Gauge symmetry and dissipative dynamics in probability spaces"*
(book line 2128), following work-package **N6** of `FORMALIZATION_ROADMAP.md`.

Sections G.0–G.7:
* G.0 the gauge group of a parametrization,
* G.1 orbits = fibers; gauge-invariance ⇔ factoring through `π`,
* G.2 gauge-invariant subalgebras; gauge-independence of expectation values,
* G.3 the Dirac obstruction (no shift-invariant state on `ℤ`),
* G.4 gauge-fixing sections always exist,
* G.5 Haar averaging (invariantization) and the pushforward headline,
* G.6 the BRST ghost algebra (nilpotency),
* G.7 dissipative dynamics: Koopman evolution.

None of these needs an `EXTERNAL` hypothesis; everything is `sorry`-free.
-/

open scoped ComplexConjugate InnerProductSpace Matrix

namespace BookProof.ChapterG

/-! ## G.0 — Parametrization and its gauge group -/





/-! ## G.1 — Orbits are fibers; gauge-invariance ⇔ factoring -/







/-! ## G.2 — Gauge-invariant subalgebras and expectation values -/







/-! ## G.3 — The Dirac obstruction: no gauge-invariant normalized state -/

open MeasureTheory









/-! ## G.4 — Gauge-fixing: sections always exist -/





/-! ## G.5 — Haar averaging (invariantization) and the pushforward headline -/

section Haar

variable {G : Type*} [Group G] [MeasurableSpace G]
variable {μG : Measure G} [IsProbabilityMeasure μG] [μG.IsMulLeftInvariant]
variable {X : Type*} [MulAction G X]











end Haar



/-! ## G.6 — BRST ghost algebra (nilpotency) -/

section BRST

variable {A : Type*} [Ring A]













/-- The BRST charge `Ω = Q·ψ†` for a gauge generator `Q` (book: `Ω=(πφ+π*φ*)ψ†`). -/
def BRST (Q : A) : Matrix (Fin 2) (Fin 2) A := !![0, 0; Q, 0]



end BRST

/-! ## G.7 — Dissipative dynamics: Koopman evolution -/









/-! ### G.7a — the Koopman unitary of a measure-preserving equivalence -/

section Koopman

variable {α β E : Type*} [MeasurableSpace α] [MeasurableSpace β]
  [NormedAddCommGroup E] [NormedSpace ℝ E] {μ : Measure α} {ν : Measure β}
  {p : ENNReal} [Fact (1 ≤ p)]





/-! ## G.13 — Parametrization implies gauge group existence

From book.tex lines 2240–2251: every parametrization `π : X → Y` has an
associated gauge group acting on `X` such that `π` is invariant under the
group action.
-/



/-! ## G.14 — Gauge symmetry vs anomalies

From book.tex lines 2394–2400: a gauge symmetry cannot exhibit anomalies
because there is no symmetry-breaking parameter.  Formally: expectation
values of gauge-invariant operators are invariant under the gauge group
action.  An anomaly would appear as a failure of this invariance.
-/





end Koopman

/-! ## G.13 — Unconstrained gauge-fixing

From book.tex lines 2334–2348: a gauge-fixing is *unconstrained* when the
gauge generators are necessarily excluded from the commutative von Neumann
algebra and thus do not impose constraints on the spectrum of the algebra.
The commutative algebra used in the gauge-fixing is necessarily commutative
(bounded commuting normal operators can always be simultaneously diagonalized),
so the gauge generators (which are non-commutative in general) cannot be
members of it.
-/





/-! ## G.14 — Two-basis correspondence

From book.tex lines 2356–2366: there is always one basis where the gauge
unitary transformations are functions of the spectrum (constrained basis) and
another basis where they are not (unconstrained basis). The expectation
values of gauge-invariant operators are the same in both bases.
-/







/-! ## G.15 — Casimir operator constraints

From book.tex lines 2368–2370: it suffices to constrain to zero the Casimir
operators of the (eventually non-commutative) Lie algebra of constraints;
this imposes the constraints without the need for the constraints to be part
of the commutative von Neumann algebra.
-/



end BookProof.ChapterG



/-!
# Chapter "Free field parametrization … Navier-Stokes", §"Free field parametrization in
Navier-Stokes equations" — the fermionic ghost field and BRST charge

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier-Stokes equations"*, §*"Free field parametrization in
Navier-Stokes equations"* (line ~4134).

The book builds the Navier–Stokes Hilbert space as a tensor product of symmetric
and antisymmetric Fock spaces, giving a graded Lie superalgebra of bosonic and
fermionic creation/annihilation operators.  The **divergence constraint** is
imposed via a single fermionic *ghost* field `ψ` (with its space derivatives
`ψ_j`), and the **BRST charge** is

```
Ω = ∫ d³x …  a†(x,…) [ u_{j,j} ψ† ] a(x,…).
```

The book specifies the ghost's canonical *anti*commutation relations and its
concrete action on the two–dimensional `ℤ₂` Fock factor:

```
{ψ, ψ†} = ψ ψ† + ψ† ψ = 1
ψ†{a}(j) = a(1) δ_{j0}          ψ{a}(j) = a(0) δ_{j1}
```

This file formalizes the self-contained mathematical content of that
construction:

* the single fermionic mode as the concrete `2×2` matrix model on the `ℤ₂` Fock
  factor `ℂ²`, its **canonical anticommutation relations** (CAR)
  `{ψ,ψ†} = 1`, `ψ² = 0`, `ψ†² = 0`, and `ψ† = ψᴴ`;
* the ghost **number operator** `N = ψ†ψ` is an orthogonal projection
  (`N² = N`, `N = Nᴴ`) — the fermionic occupation is `0` or `1` (Pauli
  exclusion), and `N + ψψ† = 1`;
* the abstract **nilpotency of the BRST charge** `Ω² = 0`, which is the reason
  the BRST cohomology is defined: for any operator `b` that commutes with a
  square-zero ghost factor `f` (`f² = 0`), the composite `Ω = b·f` satisfies
  `Ω² = 0`.
-/

namespace BookProof.GhostField

open Matrix

/-! ### The single fermionic mode on the `ℤ₂` Fock factor `ℂ²`

We index the two–dimensional `ℤ₂` Fock factor by `Fin 2`: index `0` is the
empty (vacuum) ghost state, index `1` the occupied ghost state.  A vector
`a : Fin 2 → ℂ` has components `a 0`, `a 1`. -/

/-- The ghost annihilation operator `ψ`: `ψ{a}(j) = a(0) δ_{j1}`, i.e. it maps
`(a₀, a₁) ↦ (0, a₀)`. -/
def psi : Matrix (Fin 2) (Fin 2) ℂ := !![0, 0; 1, 0]











/-! ### The ghost number operator -/











/-! ### Nilpotency of the BRST charge

The book's BRST charge is `Ω = ∫ … [u_{j,j} ψ†]`.  The single essential
algebraic property that makes the BRST construction work is `Ω² = 0`.  Abstractly
this holds in *any* (possibly noncommutative) ring: if the ghost factor `f` is
square-zero and the bosonic factor `b` commutes with it, then `Ω = b·f`
satisfies `Ω² = 0`.  Here `f = ψ†` (square-zero by `psiDag_sq`) and `b`
represents the number-conserving field factor `u_{j,j}`. -/





end BookProof.GhostField



/-!
# Chapter "Wave-function parametrization of a probability measure", §4 —
# Quantum Mechanics versus a non-commutative generalization of probability theory

This file formalizes the concrete **2-dimensional real** comparison with Gleason's
theorem given in the `book.tex` chapter *"Wave-function parametrization of a
probability measure"*, section *"4. Quantum Mechanics versus a non-commutative
generalization of probability theory"* (`book.tex` line ~1550).

The book contrasts the wave-function parametrization (which uses only *commuting*
projections, hence pure states) with Gleason's theorem (which handles
*non-commuting* projections and requires mixed states). It exhibits two
non-commuting rank-one projections on `ℝ²`,

* `P₁ = !![1,0;0,0]`  (projection onto the first axis), and
* `Q  = ½ !![1,1;1,1]` (projection onto the diagonal `(1,1)`),

together with the two expectation constraints
`tr(ρ P₁) = ½` and `tr(ρ Q) = ½`, and observes:

* there **is** a *pure* state realizing each constraint separately;
* there is **no** *pure* state realizing **both** simultaneously; yet
* the *mixed* state `ρ = ½·I` realizes both.

We model a real pure state by a unit vector `v : Fin 2 → ℝ` through the rank-one
density matrix `ρ = v vᵀ = Matrix.vecMulVec v v`, and the expectation by the
trace `tr(ρ A)`.  A short computation gives the two expectation formulas
`tr(v vᵀ · P₁) = v₀²` and `tr(v vᵀ · Q) = (v₀+v₁)²/2`, from which every claim
follows.
-/

open scoped Matrix BigOperators

namespace BookProof.ChapterGleason2D





/-- The real rank-one density matrix (pure state) attached to a vector `v`,
`ρ = v vᵀ`. -/
def pure (v : Fin 2 → ℝ) : Matrix (Fin 2) (Fin 2) ℝ := Matrix.vecMulVec v v



/-! ## Basic non-commutativity: the two projections do not commute. -/

/-
`P₁` and `Q` are non-commuting projections (the book's complementary
observables).
-/


/-
Both `P₁` and `Q` are genuine orthogonal projections (`M² = M`, symmetric,
trace one).
-/




/-! ## The two expectation formulas for a pure state `ρ = v vᵀ`. -/

/-
`tr(v vᵀ · P₁) = v₀²`.
-/


/-
`tr(v vᵀ · Q) = (v₀ + v₁)² / 2`.
-/


/-! ## A pure state realizes each constraint separately. -/

/-
The unit vector `w = (1/√2, 1/√2)` gives a pure state with `tr(ρ Q) = ½`
(it also has unit norm).
-/


/-
A pure state realizing `tr(ρ P₁) = ½`: the unit vector `w = (1/√2, 1/√2)`
gives `tr(w wᵀ P₁) = w₀² = ½`.
-/


/-! ## No pure state realizes both constraints simultaneously. -/

/-
**The key impossibility.** There is no real unit vector `v` (pure state
`ρ = v vᵀ`) with `tr(ρ P₁) = ½` and `tr(ρ Q) = ½` simultaneously.
-/


/-! ## The mixed state `ρ = ½·I` realizes both constraints. -/

/-
The maximally mixed state `ρ = ½·I` is a density matrix (`tr ρ = 1`) and
realizes both expectation constraints `tr(ρ P₁) = ½`, `tr(ρ Q) = ½`, exactly as
Gleason's theorem predicts for the non-commuting pair.
-/


end BookProof.ChapterGleason2D



/-!
# Chapter — Diffeomorphisms and gravity: the spatial projector `χ = δ + v⊗v`

Source: `book.tex`, chapter *"Diffeomorphisms and gravity"*, §*"Classical
Hamiltonian"* (line ~8091).  In the Einstein–Cartan / teleparallel Hamiltonian
formalism the author introduces, relative to a globally defined **unit timelike
vector** `v` (`vᵘ vᵤ = −1` in the mostly-plus Minkowski metric
`η = diag(−1,1,1,1)`), the mixed tensor

`χ_a{}^b = δ_a{}^b + v_a v^b`,

which is used pervasively to decompose all the torsion tensors into their
spatial (`3`-dimensional) and temporal parts.  This `χ` is exactly the
**orthogonal projector onto the spatial hyperplane** `v^⊥`: it annihilates `v`,
is idempotent, has trace `3` (it is a rank-`3` projector, the spatial slice), and
acts as the identity on vectors orthogonal to `v`.

This file makes those self-contained linear-algebra facts precise, modelling the
`(1,1)` tensor `χ^a{}_b = δ^a{}_b + v^a v_b` (raising the free index so it acts
on contravariant vectors) as an explicit `4×4` real matrix.

Formalized here (all under the physical unit-timelike hypothesis
`minkSq v = -1`, i.e. `−v₀² + v₁² + v₂² + v₃² = −1`):

* `metric` — the Minkowski metric `η = diag(−1,1,1,1)`;
* `lower v` — index lowering `v_a = η_{ab} v^b`;
* `minkSq v` — the Minkowski square `v^a v_a`;
* `spatialProj v` — the projector `χ^a{}_b = δ^a{}_b + v^a v_b`;
* `spatialProj_mulVec_self` — `χ` annihilates `v` (`v` spans the kernel);
* `spatialProj_idempotent` — `χ² = χ` (it is a genuine projector);
* `trace_spatialProj` — `tr χ = 3` (rank `3`: the spatial slice);
* `spatialProj_mulVec_of_orthogonal` — `χ` is the identity on `v^⊥`, so it is the
  orthogonal projection onto the spatial hyperplane.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); no `EXTERNAL` hypothesis, no `axiom`.
-/

namespace BookProof.ChapterGravityProjector

open Matrix
open scoped BigOperators

/-- The Minkowski metric `η = diag(−1, 1, 1, 1)` (mostly-plus convention). -/
noncomputable def metric : Matrix (Fin 4) (Fin 4) ℝ :=
  Matrix.diagonal (fun i => if i = 0 then -1 else 1)

/-- Index lowering `v_a = η_{ab} v^b`. -/
noncomputable def lower (v : Fin 4 → ℝ) : Fin 4 → ℝ := metric.mulVec v





/-
`χ` annihilates the timelike vector `v`: `χ v = 0`, so `v` spans the kernel
of the spatial projector.
-/


/-
`χ` is idempotent: `χ² = χ`, i.e. it is a genuine projector.
-/


/-
`χ` has trace `3`: it is a rank-`3` projector (the `3`-dimensional spatial
slice orthogonal to `v`).
-/


/-
`χ` acts as the identity on vectors orthogonal to `v` (`v_a x^a = 0`), so it
is the orthogonal projection onto the spatial hyperplane `v^⊥`.
-/


end BookProof.ChapterGravityProjector



/-!
# Chapter H1 — Hashimoto SIRK: φ-functions and resolvent algebra (roadmap N13, §0 S7)

This file formalizes the algebraic backbone of the Hashimoto–Nodera *Shift-invert
Rational Krylov (SIRK)* method (source `RiemannProof/Hashimoto.md`; `book.tex`
cites at lines 1147 / 2055).  It follows §0 S7 of the roadmap (the numerical
backbone of the Mehler/Hashimoto Fock formalism), and the `IsSchurFull`/`EXTERNAL`
design pattern: the genuinely deep analytic inputs (Crouzeix's inequality, the
Göckler–Grimm / Hashimoto RK error theorems) are named hypotheses with citation
docstrings in `ChapterH2.lean`, never axioms; everything here is proved outright.

## Deliverables (this file)

* **H1.1 — the φ-functions.** `phi : ℕ → ℂ → ℂ`, `phi 0 = exp`,
  `phi (k+1) z = ∫ s in 0..1, exp (s·z)·(1−s)^k / k!` (eq. 3); `phi_zero`,
  `phi_at_zero : phi k 0 = 1/k!`.
* **H1.2 — the φ-recurrence.** `phi_succ_mul : z · phi (k+1) z = phi k z − 1/k!`
  (integration by parts); corollary `phi_one : z ≠ 0 → phi 1 z = (exp z − 1)/z`.
* **H1.4 — numerical range & eigenvalue inclusion.** `numericalRange A` (the set
  of Rayleigh quotients) with `eigenvalue_mem_numericalRange` (every eigenvalue
  lies in `W(A)` — the easy half of Toeplitz–Hausdorff).
* **H1.6 — the resolvent shift identity (the clean SIRK algebra core).** The
  resolvent identity `resolvent_identity` and the SIRK shift form
  `resolvent_shift_mul : X_j · (1 + h(m−j)·X_m) = X_m` for `γ_j = N − h·j`
  (§4, between eqs. (10)–(11)) — purely algebraic, no analysis.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.
-/

open scoped BigOperators
open intervalIntegral

namespace BookProof.ChapterH1

noncomputable section

/-! ## H1.1 — the φ-functions and their values -/

/-- The φ-functions (Hashimoto eq. 3): `φ₀ = exp`, and for `k ≥ 0`
`φ_{k+1}(z) = ∫₀¹ e^{s z} (1−s)^k / k! ds`.  Each `φ_k` is entire (a convergent
power series). -/
noncomputable def phi : ℕ → ℂ → ℂ
  | 0, z => Complex.exp z
  | (k + 1), z => ∫ s in (0 : ℝ)..1, Complex.exp (s * z) * (1 - s) ^ k / k.factorial







/-
**H1.1** (values at `0`): `φ_k(0) = 1/k!`.
For `k = 0` this is `exp 0 = 1`.  For `k+1`, the integrand at `z = 0` is
`(1−s)^k / k!`, whose integral over `[0,1]` is `1/((k+1)·k!) = 1/(k+1)!`.
-/


/-! ## H1.2 — the φ-recurrence -/

/-
**H1.2** (recurrence): `z · φ_{k+1}(z) = φ_k(z) − 1/k!`.
Integration by parts on the defining integral: with `u = e^{s z}` and
`dv = (1−s)^k/k! ds`, the boundary terms give `φ_k(z) − 1/k!` and the remaining
integral is `z·φ_{k+1}(z)`.
-/




/-! ## H1.3 — the exponential-integrator Duhamel identity -/



/-
**H1.3** (exponential-integrator Duhamel identity, scheme (4)): for a
(bounded) operator `A` the constant-forcing Duhamel term is the operator
φ₁-function, `∫₀^δ e^{(δ−s)·A} g ds = δ · phiOp1 (δ·A) g`.  Proof: substitute
`u = δ − s` (`integral_comp_sub_left`) on the left and `u = δ s`
(`smul_integral_comp_mul_left`) on the right; both equal `∫₀^δ e^{u·A} g du`.
-/


/-! ## H1.4 — numerical range and eigenvalue inclusion -/

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]



/-
**H1.4** (eigenvalue inclusion — the easy half of Toeplitz–Hausdorff): every
eigenvalue of `A` lies in its numerical range.  If `A v = λ v` with `‖v‖ = 1`,
then `⟪v, A v⟫ = λ·⟪v, v⟫ = λ·‖v‖² = λ`.
-/


/-! ## H1.5 — the operator φ-function via the resolvent (Definition 2.4) -/

/-- The Taylor(1951)/Güttel(2010) transformed function `ψ_{k,γ}(x) := φ_k(γ − x⁻¹)`
(Hashimoto Definition 2.4).  The operator φ-function is then `φ_k(A) = ψ_{k,γ}(X)`
with `X = (γI − A)⁻¹` (evaluated by the holomorphic functional calculus). -/
noncomputable def psi (k : ℕ) (γ : ℂ) (x : ℂ) : ℂ := phi k (γ - x⁻¹)

/-
**H1.5** (scalar defining identity, Definition 2.4): at an eigenvalue `z` of
`A` the resolvent has eigenvalue `(γ − z)⁻¹`, and the transformed function
recovers `φ_k`: `ψ_{k,γ}((γ − z)⁻¹) = φ_k(z)`.  This is the spectral/
finite-rank-component identity that (via §0 S3, the holomorphic functional
calculus `f_γ((γI−A)⁻¹) = f(A)`) lifts to the operator equality `φ_k(A) =
ψ_{k,γ}(X)`.
-/


/-
**H1.5** (resolvent eigenvector, the spectral bridge): if `A v = z v` and
`γ − z` is invertible, then `v` is an eigenvector of the resolvent
`X = (γI − A)⁻¹` with eigenvalue `(γ − z)⁻¹`, i.e. `X v = (γ − z)⁻¹ • v`.
This is the per-component reduction underlying the CFC identity of H1.5.
-/


/-! ## H1.6 — the resolvent shift identity (the clean SIRK algebra core) -/

variable {A : Type*} [Ring A] [Algebra ℂ A]

/-
**H1.6** (resolvent identity): if `X_j` and `X_m` are two-sided inverses of
the shifted operators `γ_j·1 − a` and `γ_m·1 − a`, then
`X_j − X_m = (γ_m − γ_j)·(X_j · X_m)`.  Purely algebraic: insert the two
inverses and cancel `a`.
-/


/-
**H1.6** (SIRK shift form): with the SIRK shifts `γ_j = N − h·j` the resolvent
identity rearranges to `X_j · (1 + h·(m−j)·X_m) = X_m`.  This is the algebraic
core that turns the rational-Krylov recurrence into a shift-invert recurrence
(§4, between eqs. (10)–(11)); no analysis is needed.
-/


/-
**H1.7** (rational-Krylov representation, eq. 11 generating step): with the SIRK
shifts `γ_j = N − h·j` the resolvent `X_j` is the rational function
`X_j = (1 + h(m−j)·X_m)⁻¹ · X_m` of `X_m` (Hashimoto §4, "Since `X_j` is
represented as …").  This is the load-bearing algebraic identity from which the
rational-Krylov subspace equality `Q_m({X_j}, v) = {r(X_m) v | r ∈ R_SIRK}`
(eq. 11) follows by induction: each `X_j` raises the numerator degree by ≤ 1 and
multiplies the denominator by one more `(1 + h·i·z)` factor.  Purely algebraic,
from the H1.6 shift identity + commutativity of `X_m` with `1 + h(m−j)·X_m`.
-/


end

end BookProof.ChapterH1



/-!
# The Hermite functions: orthonormality, completeness, and the Hermite core of `L²(ℝ)`

This chapter supplies the concrete object that the abstract Galerkin/Friedrichs
chapter (`BookProof/ChapterHermiteGalerkinFriedrichs.lean`) and the quantum
gravity chapter (`BookProof/ChapterQuantumGravityDensitized.lean`) so far only
used *abstractly*: a genuine **Hilbert basis of Hermite functions** of `L²(ℝ)`,
and hence a genuine **Hermite core** — the space of finite linear combinations of
Hermite functions, i.e. "polynomials times the Gaussian".

The convention is the probabilists' one: `H_{n+1} = X H_n − H_n'`
(`Polynomial.hermite` of Mathlib), and the Hermite *functions* are

  `ψ_n(x) = H_n(x) e^{-x²/4}`,   `∫ ψ_m ψ_n = δ_{mn} n! √(2π)`.

Contents:

* `hermiteR`, `derivative_hermiteR`, `hermiteR_ode` — the polynomials, the
  derivative rule `H_{n+1}' = (n+1) H_n` and the Hermite differential equation;
* `gint_ibp` — integration by parts against the Gaussian weight on all of `ℝ`;
* `hermiteInner_eq` — the orthogonality relations
  `∫ H_m H_n e^{-x²/2} = δ_{mn} n! √(2π)`;
* `orthonormal_hermiteLp` — the normalized Hermite functions are orthonormal in
  `L²(ℝ, ℂ)`;
* `hermiteLp_span_dense`, `hermiteBasis` — completeness: they form a Hilbert
  basis (proved from scratch: orthogonality to all `xⁿ e^{-x²/4}` forces the
  Fourier transform of `e^{-x²/4} u` to vanish identically);
* `hermiteFun_oscillator` — each Hermite function is an eigenfunction of the
  harmonic oscillator `-d²/dx² + x²/4` with eigenvalue `n + 1/2`.
-/

namespace BookProof.HermiteCore

open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

/-! ## The Hermite polynomials over `ℝ` -/

/-- The (probabilists') Hermite polynomials, as real polynomials. -/
def hermiteR (n : ℕ) : Polynomial ℝ := (Polynomial.hermite n).map (Int.castRingHom ℝ)











/-! ## The Gaussian weights -/

/-- The Gaussian weight `e^{-x²/2}` of the Hermite polynomials. -/
def gaussW (x : ℝ) : ℝ := Real.exp (-x ^ 2 / 2)

/-- The half weight `e^{-x²/4}`, which turns Hermite *polynomials* into Hermite
*functions*. -/
def gaussH (x : ℝ) : ℝ := Real.exp (-x ^ 2 / 4)



theorem continuous_gaussH : Continuous gaussH := by
  unfold gaussH; fun_prop





theorem gaussH_sq (x : ℝ) : gaussH x * gaussH x = gaussW x := by
  rw [gaussH, gaussW, ← Real.exp_add]; ring_nf





/-- Every monomial is integrable against a Gaussian. -/
theorem integrable_pow_mul_exp_neg (k : ℕ) {b : ℝ} (hb : 0 < b) :
    Integrable (fun x : ℝ => x ^ k * Real.exp (-b * x ^ 2)) := by
  have hdom : Integrable
      (fun x : ℝ => ((k.factorial : ℝ) * Real.exp (1 / (2 * b))) * Real.exp (-(b / 2) * x ^ 2)) :=
    (integrable_exp_neg_mul_sq (by positivity)).const_mul _
  refine hdom.mono' (Continuous.aestronglyMeasurable (by fun_prop)) ?_
  filter_upwards with x
  have hfac : (0 : ℝ) < (k.factorial : ℝ) := by positivity
  have h1 : |x| ^ k ≤ (k.factorial : ℝ) * Real.exp |x| := by
    have h := Real.pow_div_factorial_le_exp |x| (abs_nonneg x) k
    rw [div_le_iff₀ hfac] at h
    linarith [h]
  have h2 : |x| - b * x ^ 2 ≤ 1 / (2 * b) - (b / 2) * x ^ 2 := by
    have hx2 : x ^ 2 = |x| ^ 2 := (sq_abs x).symm
    rw [hx2, ← sub_nonneg]
    have key : 1 / (2 * b) - b / 2 * |x| ^ 2 - (|x| - b * |x| ^ 2)
        = (b * |x| - 1) ^ 2 / (2 * b) := by
      field_simp
      ring
    rw [key]
    positivity
  have hnorm : ‖x ^ k * Real.exp (-b * x ^ 2)‖ = |x| ^ k * Real.exp (-b * x ^ 2) := by
    rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_pow, abs_of_pos (Real.exp_pos _)]
  rw [hnorm]
  calc |x| ^ k * Real.exp (-b * x ^ 2)
      ≤ ((k.factorial : ℝ) * Real.exp |x|) * Real.exp (-b * x ^ 2) := by gcongr
    _ = (k.factorial : ℝ) * Real.exp (|x| - b * x ^ 2) := by
          rw [mul_assoc, ← Real.exp_add]; ring_nf
    _ ≤ (k.factorial : ℝ) * Real.exp (1 / (2 * b) - (b / 2) * x ^ 2) := by gcongr
    _ = ((k.factorial : ℝ) * Real.exp (1 / (2 * b))) * Real.exp (-(b / 2) * x ^ 2) := by
          rw [mul_assoc, ← Real.exp_add]; ring_nf

/-- Every polynomial is integrable against a Gaussian. -/
theorem integrable_poly_mul_exp_neg (p : Polynomial ℝ) {b : ℝ} (hb : 0 < b) :
    Integrable (fun x : ℝ => p.eval x * Real.exp (-b * x ^ 2)) := by
  induction p using Polynomial.induction_on' with
  | add p q hp hq => simpa [add_mul] using hp.add hq
  | monomial k a =>
      simpa [Polynomial.eval_monomial, mul_assoc] using
        (integrable_pow_mul_exp_neg k hb).const_mul a

theorem integrable_poly_mul_gaussW (p : Polynomial ℝ) :
    Integrable (fun x : ℝ => p.eval x * gaussW x) := by
  have h := integrable_poly_mul_exp_neg p (b := 1 / 2) (by norm_num)
  refine h.congr (Filter.Eventually.of_forall fun x => ?_)
  simp only [gaussW]
  ring_nf



/-! ## The Gaussian-weighted integral of a polynomial -/

/-- `gint p = ∫ p(x) e^{-x²/2} dx`, the Gaussian-weighted integral. -/
def gint (p : Polynomial ℝ) : ℝ := ∫ x : ℝ, p.eval x * gaussW x













/-! ## Orthogonality -/















/-! ## The Hermite functions in `L²(ℝ, ℂ)` -/

/-- The Hermite function `ψ_n(x) = H_n(x) e^{-x²/4}`. -/
def hermiteFun (n : ℕ) (x : ℝ) : ℝ := (hermiteR n).eval x * gaussH x



/-- The `L²` normalizing constant `√(n! √(2π))`. -/
def hermiteNorm (n : ℕ) : ℝ := Real.sqrt ((n.factorial : ℝ) * Real.sqrt (2 * Real.pi))





/-- The normalized Hermite function, as a complex valued function on `ℝ`. -/
def hermiteC (n : ℕ) : ℝ → ℂ := fun x => ((hermiteFun n x / hermiteNorm n : ℝ) : ℂ)

/-- Any polynomial times the half Gaussian is square integrable. -/
theorem memLp_poly_mul_gaussH (p : Polynomial ℝ) :
    MemLp (fun x : ℝ => ((p.eval x * gaussH x : ℝ) : ℂ)) 2 (volume : Measure ℝ) := by
  have hmeas : AEStronglyMeasurable (fun x : ℝ => ((p.eval x * gaussH x : ℝ) : ℂ))
      (volume : Measure ℝ) := by
    refine Continuous.aestronglyMeasurable ?_
    exact Complex.continuous_ofReal.comp (p.continuous_aeval.mul continuous_gaussH)
  rw [memLp_two_iff_integrable_sq_norm hmeas]
  refine (integrable_poly_mul_gaussW (p * p)).congr (Filter.Eventually.of_forall fun x => ?_)
  simp only [Polynomial.eval_mul, Complex.norm_real, Real.norm_eq_abs]
  rw [← abs_pow, abs_of_nonneg (by positivity : (0:ℝ) ≤ (p.eval x * gaussH x) ^ 2)]
  rw [show (p.eval x * gaussH x) ^ 2 = p.eval x * p.eval x * (gaussH x * gaussH x) by ring,
    gaussH_sq]

theorem memLp_hermiteC (n : ℕ) : MemLp (hermiteC n) 2 (volume : Measure ℝ) := by
  have h := memLp_poly_mul_gaussH (C (1 / hermiteNorm n) * hermiteR n)
  refine (memLp_congr_ae (Filter.Eventually.of_forall fun x => ?_)).mp h
  simp only [hermiteC, hermiteFun, Polynomial.eval_mul, Polynomial.eval_C]
  push_cast
  ring

/-- The normalized Hermite functions as elements of `L²(ℝ, ℂ)`. -/
def hermiteLp (n : ℕ) : Lp ℂ 2 (volume : Measure ℝ) := (memLp_hermiteC n).toLp _





/-! ## Completeness

The completeness proof is elementary but not short.  If `u ∈ L²(ℝ)` is
orthogonal to every Hermite function then it is orthogonal to every `xᵏ e^{-x²/4}`
(the Hermite polynomials are monic of every degree), hence — expanding the
character `e^{-2πiwx}` in its power series and integrating term by term, which
dominated convergence allows because `e^{c|x|}e^{-x²/4}` is still square
integrable — the Fourier transform of the `L¹` function `e^{-x²/4} u` vanishes
identically, so `u = 0`. -/



































/-! ## The harmonic oscillator -/









end

end BookProof.HermiteCore



/-!
# Chapter KrylovShiftSpan — the multi-shift Krylov spaces

The SIRK/Hashimoto solver builds its subspace either from the **shifted products**
`v, (H − z₀)v, (H − z₁)(H − z₀)v, …` or from the **resolvent (rational Krylov)**
sequence `v, X₀v, X₁X₀v, …` with `Xᵢ = (H − zᵢ)⁻¹`, for a sequence of (possibly
distinct, possibly complex) shifts, while the theory is written for the plain Krylov
space `span{v, Hv, …, Hᵏv}`.

This chapter proves that all three descriptions agree, in the algebraic generality in
which they are true: no topology, no self-adjointness, an arbitrary module over an
arbitrary commutative ring, and an arbitrary shift sequence.

### Relation to the rest of the development

The *forward-sequence* half of the statement is already available analytically in
`BookProof/ChapterSirkMultiShift.lean` (`krylov_multiShift_eq_standard`,
`krylov_multiShift_span_eq_of_shifts`), over a field and for vectors of the sequence;
what is re-proved here is its purely algebraic operator-product form
(`forwardProd`, over a commutative ring), because the resolvent statement below needs
the products themselves, not just the vectors they produce.  The *resolvent* half is
new: `BookProof/ChapterHashimotoComplexShifts.lean` describes the rational Krylov space
as rational functions of one fixed resolvent (`sirkDen_rkVec`), whereas
`resolventSpan_eq_map_krylovSpan` below identifies it with the image of the ordinary
Krylov space of `H` itself under the product of the resolvents.

## Deliverables

* `shiftOp T z = T − z`, `forwardProd T z j = (T − z_{j−1}) ⋯ (T − z₀)` and
  `krylovSpan` / `forwardSpan` — the plain and the shifted Krylov subspaces.
* **`forwardSpan_eq_krylovSpan`** — the two spans coincide at every truncation level `k`:
  the shifted forward sequence spans exactly the Krylov space.  Hence
  `forwardSpan_eq_forwardSpan` : *the span does not depend on the shifts at all*, which is
  what makes the numerics' freedom to choose (and to reorder, or to repeat) the shifts
  harmless.
* `resProd X j = X_{j−1} ⋯ X₀` and `resolventSpan`; `commute_resolvent_shiftOp` and
  `resProd_mul_tailProd` — the resolvent of one shift commutes with every shifted
  operator, and the resolvents telescope against the shifted products.
* **`resolventSpan_eq_map_krylovSpan`** — the rational (resolvent) Krylov space is the
  image of the ordinary Krylov space under the product of all `k` resolvents:
  `span{v, X₀v, X₁X₀v, …, X_{k−1}⋯X₀v} = (X_{k−1}⋯X₀) '' span{v, Tv, …, Tᵏv}`.
  So the three subspaces the plan lists are the same subspace up to the invertible factor
  `X_{k−1}⋯X₀`.  (No permutation statement is claimed; what is proved is the description
  above, which is the form the compression arguments use.)  The bridge is
  `tailSpan_eq_krylovSpan`: the tail products `(T − z_{k−1}) ⋯ (T − z_j)`, `j ≤ k`, are
  the forward products of the *reversed* shift sequence, hence span the Krylov space too.
* `resProd_mul_forwardProd` / `forwardProd_mul_resProd` (the two products are mutually
  inverse) and hence `krylovSpan_eq_map_resolventSpan`, the inverse form of the identity
  above.
* `resVec` and `resolventSpan_eq_span_resVec` — the resolvent span written with the
  vectors the solver actually computes, `v, X₀v, X₁X₀v, …`, one resolvent solve at a time.
* **`resolventSpan_of_perm`** — *the rational Krylov space does not depend on the order in
  which the shifts are used*: for a permutation of `ℕ` fixing everything from `k` on,
  the reordered schedule reaches the same subspace (`resProd_of_perm`: the product of the
  resolvents is order-independent, since they commute).  The intermediate flag does
  change; the space at level `k` does not.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.KrylovShiftSpan

variable {R : Type*} [CommRing R] {V : Type*} [AddCommGroup V] [Module R V]

/-! ## 1. The shifted operators and the two spans -/

/-- The shifted operator `T − z`. -/
def shiftOp (T : Module.End R V) (z : R) : Module.End R V := T - z • (1 : Module.End R V)































/-! ## 2. The resolvent (rational Krylov) side -/

section Resolvent

variable (T : Module.End R V) (z : ℕ → R) (X : ℕ → Module.End R V)











variable {T z X}



























/-! ## 3. The tail products span the Krylov space again -/









/-! ## 4. The two spans are carried into each other by inverse operators -/







/-! ## 5. The rational Krylov vectors -/












/-! ## 6. Reordering the shift schedule -/











end Resolvent

end BookProof.KrylovShiftSpan



/-!
# The `L∞(μ)` class of the abelian von Neumann classification

The classification of abelian von Neumann algebras quoted in the book lists
three kinds of model: the finite diagonal algebras `ℓ∞(n)` (proved in
`ChapterAbelianDiagonal` / `ChapterAbelianVonNeumannFinite`), the countable
diagonal algebra `ℓ∞(ℕ)` acting on `ℓ²(ℕ)` (proved in
`ChapterAbelianDiagonalCountable`), and the **diffuse** model `L∞(μ)` acting on
`L²(μ)` by multiplication.  Only the last was missing; this module builds it.

For a measure `μ` on `α` and an essentially bounded `φ : α → ℂ`
(`MemLp φ ⊤ μ`), the multiplication operator

  `multOp φ : L²(μ) →L[ℂ] L²(μ)`,  `f ↦ φ · f`

is constructed and shown to make `φ ↦ multOp φ` a **unital, multiplicative,
`ℂ`-linear, star-preserving and commuting** representation of the essentially
bounded functions:

* `multOp_coeFn` — its defining a.e. formula `(multOp φ f)(x) = φ(x)·f(x)`;
* `norm_multOp_le` — the operator-norm bound by the essential supremum;
* `multOp_add`, `multOp_smul`, `multOp_mul`, `multOp_one` — `φ ↦ multOp φ` is a
  unital algebra homomorphism;
* `multOp_comm` — **the algebra is abelian**;
* `multOp_inner_adjoint` — `multOp (conj φ)` is the adjoint of `multOp φ`, so
  the family is star-closed and the self-adjoint elements are the real-valued
  `φ`;
* `multOp_eq_zero_iff` (finite `μ`) — the representation is **faithful**:
  `multOp φ = 0` iff `φ = 0` a.e., so `L∞(μ)` embeds into `B(L²(μ))`;
* `vonNeumann_abelian_class_Linfty` — the bundled statement, and
  `unitInterval_atomless` — for `μ = ` Lebesgue measure on `[0,1]` the model is
  *diffuse* (`μ{x} = 0` for every point), which is exactly what distinguishes it
  from the atomic `ℓ∞` models.

**Documented gap (unchanged).**  That every abelian von Neumann algebra is
*exhausted* by this list is not claimed here; it needs von-Neumann-algebra
machinery unavailable in this toolchain.  What is proved is that the `L∞(μ)`
item of the list is a genuine abelian, faithful, star-closed operator algebra.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory ENNReal Complex

namespace BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}

/-! ## The multiplication operator -/

/-- Multiplying an `L²` function by an essentially bounded function stays in
`L²` (Hölder with exponents `∞, 2, 2`). -/
theorem mul_memLp_two {φ : α → ℂ} (hφ : MemLp φ ⊤ μ) (f : Lp ℂ 2 μ) :
    MemLp (fun x => φ x * (f : α → ℂ) x) 2 μ :=
  MemLp.smul (Lp.memLp f) hφ

theorem eLpNorm_mul_le {φ : α → ℂ} (hφ : MemLp φ ⊤ μ) (f : Lp ℂ 2 μ) :
    eLpNorm (fun x => φ x * (f : α → ℂ) x) 2 μ ≤ eLpNorm φ ⊤ μ * eLpNorm (f : α → ℂ) 2 μ := by
  have h : eLpNorm (φ • (f : α → ℂ)) 2 μ ≤ eLpNorm φ ⊤ μ * eLpNorm (f : α → ℂ) 2 μ :=
    eLpNorm_smul_le_mul_eLpNorm (p := ⊤) (q := 2) (r := 2)
      (Lp.memLp f).aestronglyMeasurable hφ.aestronglyMeasurable
  exact h

/-- The multiplication operator as a linear map on `L²(μ)`. -/
def multLin (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) : Lp ℂ 2 μ →ₗ[ℂ] Lp ℂ 2 μ where
  toFun f := (mul_memLp_two hφ f).toLp _
  map_add' f g := by
    refine Lp.ext ?_
    filter_upwards [MemLp.coeFn_toLp (mul_memLp_two hφ (f + g)),
      Lp.coeFn_add ((mul_memLp_two hφ f).toLp _) ((mul_memLp_two hφ g).toLp _),
      MemLp.coeFn_toLp (mul_memLp_two hφ f), MemLp.coeFn_toLp (mul_memLp_two hφ g),
      Lp.coeFn_add f g] with x h1 h2 h3 h4 h5
    simp only [h1, h2, h3, h4, h5, Pi.add_apply]
    ring
  map_smul' c f := by
    refine Lp.ext ?_
    filter_upwards [MemLp.coeFn_toLp (mul_memLp_two hφ (c • f)),
      MemLp.coeFn_toLp (mul_memLp_two hφ f),
      Lp.coeFn_smul c ((mul_memLp_two hφ f).toLp _),
      Lp.coeFn_smul c f] with x h1 h2 h3 h4
    simp only [RingHom.id_apply, h1, h2, h3, h4, Pi.smul_apply, smul_eq_mul]
    ring

theorem norm_multLin_le {φ : α → ℂ} (hφ : MemLp φ ⊤ μ) (f : Lp ℂ 2 μ) :
    ‖multLin φ hφ f‖ ≤ (eLpNorm φ ⊤ μ).toReal * ‖f‖ := by
  change ‖(mul_memLp_two hφ f).toLp _‖ ≤ _
  rw [Lp.norm_toLp, Lp.norm_def]
  have h1 : eLpNorm φ ⊤ μ ≠ ⊤ := hφ.eLpNorm_lt_top.ne
  have h2 : eLpNorm (f : α → ℂ) 2 μ ≠ ⊤ := (Lp.memLp f).eLpNorm_lt_top.ne
  calc (eLpNorm (fun x => φ x * (f : α → ℂ) x) 2 μ).toReal
      ≤ (eLpNorm φ ⊤ μ * eLpNorm (f : α → ℂ) 2 μ).toReal :=
        ENNReal.toReal_mono (ENNReal.mul_ne_top h1 h2) (eLpNorm_mul_le hφ f)
    _ = (eLpNorm φ ⊤ μ).toReal * (eLpNorm (f : α → ℂ) 2 μ).toReal := ENNReal.toReal_mul

/-- **The multiplication operator** `M_φ : L²(μ) → L²(μ)`, `f ↦ φ·f`, for an
essentially bounded `φ`. -/
def multOp (φ : α → ℂ) (hφ : MemLp φ ⊤ μ) : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ :=
  (multLin φ hφ).mkContinuous (eLpNorm φ ⊤ μ).toReal (norm_multLin_le hφ)





/-! ## The algebraic structure -/















/-! ## Faithfulness and diffuseness -/







end BookProof.ChapterLinftyMultiplication

end



/-!
# Chapter "Real representations, CPT theorem …", §"On the Lorentz, SL(2,C) and Pin(3,1) groups":
the Lorentz group `O(1,3)` and its discrete subgroup `Δ = {1, η, -η, -1}`

This file formalizes the self-contained group-theoretic content of `book.tex`
**Note 43** (`book.tex` line ~5340, chapter *"Real representations, CPT theorem
and the relativistic position operator"*, §*"On the Lorentz, SL(2,C) and
Pin(3,1) groups"*):

> The Lorentz group, `O(1,3) ≡ {λ ∈ ℝ^{4×4} : λᵀ η λ = η}`, is the set of real
> matrices that leave the metric `η = diag(1,-1,-1,-1)` invariant. […] The
> discrete Lorentz subgroup of parity and time-reversal is `Δ ≡ {1, η, -η, -1}`.

Modelling the Minkowski metric `η = diag(1,-1,-1,-1)` as an explicit real
`4×4` matrix (this uses **only** the metric, no Majorana / gamma matrices).

Results:
* `eta_transpose`, `eta_mul_self` (`η² = 1`), `eta_det` (`det η = -1`) — the basic
  properties of the metric;
* `IsLorentz` — the defining predicate of `O(1,3)`;
* `isLorentz_one`, `isLorentz_mul`, `isLorentz_inv` — `O(1,3)` is closed under the
  identity, matrix product, and matrix inverse: it is a **group**;
* `lorentz_det_sq_one` (`(det λ)² = 1`) and `lorentz_det_ne_zero` — every Lorentz
  matrix is invertible with determinant `±1`;
* `isLorentz_eta`, `isLorentz_neg_eta`, `isLorentz_neg_one` — the three nontrivial
  discrete generators are Lorentz;
* `Delta` — the discrete subgroup `Δ = {1, η, -η, -1}`;
* `delta_subset_lorentz` — `Δ ⊆ O(1,3)`;
* `delta_mul_closed` — `Δ` is closed under multiplication;
* `delta_involutive` — every element of `Δ` squares to `1`
  (so `Δ` is abelian and `≅ ℤ₂ × ℤ₂`, the Klein four-group);
* `delta_card_four` — the four listed elements are distinct, so `|Δ| = 4`.
-/

namespace BookProof.LorentzGroup

open Matrix

/-- The Minkowski metric `η = diag(1, -1, -1, -1)` as an explicit real `4×4`
matrix. -/
def eta : Matrix (Fin 4) (Fin 4) ℝ :=
  !![1, 0, 0, 0; 0, -1, 0, 0; 0, 0, -1, 0; 0, 0, 0, -1]

/-
The metric is symmetric: `ηᵀ = η`.
-/


/-
The metric is an involution: `η² = 1`.
-/


/-
The determinant of the metric is `-1`.
-/




/-
The identity matrix is a Lorentz transformation.
-/


/-
The product of two Lorentz transformations is a Lorentz transformation.
-/


/-
The determinant of a Lorentz transformation squares to `1`.
-/


/-
A Lorentz transformation has nonzero determinant, hence is invertible.
-/


/-
The inverse of a Lorentz transformation is a Lorentz transformation:
so `O(1,3)` is a group.
-/


/-
The metric `η` (parity × time-reversal) is a Lorentz transformation.
-/


/-
`-η` is a Lorentz transformation.
-/


/-
`-1` (full inversion `PT`) is a Lorentz transformation.
-/




/-
Every element of `Δ` is a Lorentz transformation: `Δ ⊆ O(1,3)`.
-/


/-
`Δ` is closed under matrix multiplication.
-/


/-
Every element of `Δ` squares to the identity: `Δ` is abelian and isomorphic
to the Klein four-group `ℤ₂ × ℤ₂`.
-/


/-
The four listed elements `1, η, -η, -1` are pairwise distinct, so `|Δ| = 4`.
-/


end BookProof.LorentzGroup



/-!
# Chapter "Free field parametrization … Navier-Stokes", §"Mass gap"

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier-Stokes equations"*, §*"Mass gap"* (line ~4061).

The book's argument (solving "the hardest part" of the Yang–Mills mass-gap
Millenium problem in its own formalism):

> "the commutative algebra of observables is generated by hermitian operators
> `a†(φ,x) a(φ,x)` … the Hamiltonian commutes with the number operator. Thus,
> the number operator commutes with the algebra of observables which implies that
> the number operator can be added to the Hamiltonian, modifying the mass gap
> without observable consequences."

So a bounded-from-below Hamiltonian with a *null* mass gap (the free
electromagnetic field) can be turned into one with an *arbitrary* mass gap
without any observable consequence.

This file formalizes the two self-contained mathematical facts behind that
claim.

## Observable invariance (the "no observable consequence" part)

Work in an arbitrary complex Banach algebra `𝔸` (the algebra of operators).
`H` is the Hamiltonian, `N` the number operator, `Obs` any observable. The
physical hypotheses are:

* `Commute H N` — the Hamiltonian commutes with the number operator;
* `Commute Obs N` — every observable commutes with the number operator (the
  observable algebra is number-conserving).

Then the Heisenberg-picture time evolution of `Obs` under the *shifted*
Hamiltonian `H + λ N` is **identical** to its evolution under `H`:

`exp(t(H+λN)) · Obs · exp(-t(H+λN)) = exp(tH) · Obs · exp(-tH)`

for every scalar `t` (the physical unitary case is `t = i s`, `s` real) and every
shift `λ`. Hence the number-operator shift is invisible to all observables.

## Spectral shift (the "modify the mass gap at will" part)

For a diagonal Hamiltonian with eigenvalues `E : Fin (n+2) → ℝ`, vacuum index `0`
with `E 0 = 0`, and number operator `numberOp i = if i = 0 then 0 else 1`, the
shifted Hamiltonian has eigenvalues `E i + λ · numberOp i`:

* the vacuum energy is unchanged (`= E 0`);
* every excited energy is shifted by exactly `λ`;
* for the **gapless** free field (`E ≡ 0`) the shifted mass gap equals `λ`, i.e.
  it can be set to any nonnegative value.
-/

namespace BookProof.MassGap

open scoped BigOperators

/-! ### Observable invariance in a complex Banach algebra -/

variable {𝔸 : Type*} [NormedRing 𝔸] [NormedAlgebra ℂ 𝔸] [CompleteSpace 𝔸]





/-! ### Diagonal spectral shift and the arbitrary mass gap -/

variable {n : ℕ}





/-- The excited states (all indices other than the vacuum `0`). -/
def excited (n : ℕ) : Finset (Fin (n + 2)) := Finset.univ.filter (· ≠ 0)

/-
The excited-state set is nonempty (index `1` is excited).
-/




/-
Vacuum energy is unchanged by the number-operator shift.
-/


/-
Every excited energy is shifted by exactly `λ`.
-/


/-
**Headline (arbitrary mass gap).** For the gapless free field (`E ≡ 0`) the
number-operator shift produces a mass gap equal to `λ`: the mass gap can be set
to any value.
-/


end BookProof.MassGap



/-!
# Chapter "Aligned deep learning as a random sampling method", §2
"Systematic uncertainties and Bayesian priors" / Chapter "Consciousness as a
representation of a Bayesian prior" — **the maximum-entropy characterization of
the uniform (non-informative) prior**

Source: `book.tex`.  The book repeatedly appeals to the *maximum-entropy* /
*non-informative prior* principle, e.g.

> *"tools and techniques of automated reasoning include … Bayesian inference,
> reasoning with **maximal entropy** and many less formal ad hoc techniques."*
> (`book.tex` line ~9772)

and it stresses that *"there are no non-informative priors and there are no
almost non-informative priors"* (`book.tex` lines ~9349, ~9451): the closest one
gets to a "non-informative" prior on a finite sample space is the **uniform**
distribution, and the precise sense in which it is the least informative is that
it **maximizes the Shannon entropy**.

This module formalizes that self-contained, classical mathematical fact,
entirely independent of the surrounding discussion.  For a finite probability
distribution `p` on a (nonempty) finite sample space `α` with `n = |α|` outcomes,
the Shannon entropy `H(p) = ∑ᵢ −pᵢ log pᵢ` satisfies

* `entropy_nonneg`   — `0 ≤ H(p)`;
* `entropy_le_log_card` — `H(p) ≤ log n` (the maximum-entropy bound, via the
  Gibbs inequality `log x ≤ x − 1`);
* `entropy_uniform`  — the uniform distribution attains it: `H(uniform) = log n`;
* HEADLINE `entropy_le_entropy_uniform` — hence the uniform distribution is the
  **maximum-entropy** distribution: `H(p) ≤ H(uniform)` for every distribution
  `p`;
* `entropy_eq_log_card_iff` — the uniform prior is the **unique** maximizer:
  `H(p) = log n` iff `p` is the uniform distribution (via the strict Gibbs
  inequality `log x < x − 1` for `x ≠ 1`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Real BigOperators Finset

namespace BookProof.ChapterMaxEntropy

variable {α : Type*} [Fintype α]





/-- The **uniform** distribution on `α`: every outcome carries weight `1/|α|`. -/
noncomputable def uniform (α : Type*) [Fintype α] : α → ℝ :=
  fun _ => (Fintype.card α : ℝ)⁻¹



















end BookProof.ChapterMaxEntropy



/-!
# The canonical (differential) form of the full quadratic Navier–Stokes symbol

`BookProof.ChapterNavierStokesThreeComponent` proves that the coupled
three-component fiber Hamiltonian

`H = ∑_i ½(π_i V_i + V_i π_i)`,  `V_i(u) = ∑_k A_{ik} u_k + c_i`,

is essentially self-adjoint on the finite-mode core of `ℓ²(Vel)`, `Vel = Fin 3 → ℕ`,
for an arbitrary real matrix `A` and an arbitrary real vector `c` — but it does so by
*writing down the Hermite matrix* of that operator, and the module records as an honest
boundary that "the differential realization on `L²(du₁du₂du₃)` is not built here".

This module removes that boundary, in the same way that
`BookProof.ChapterNavierStokesHermiteCanonical` removed it for the single linear fiber:
it builds the three canonical pairs `(u_i, π_i)` out of the Hermite ladder operators and
proves that the matrix `velH` **is** the canonically written operator.

## The Navier–Stokes symbol

In the Eulerian derivatives-as-fields picture the quadratic symbol of the Navier–Stokes
generator at one fiber is

`A_i(u) = u_j u_{i,j} − ν u_{i,jj}`,

which is an **affine** function of the velocity `u = (u₁,u₂,u₃)`: its linear part is the
velocity-gradient matrix `G_{ij} = u_{i,j}` and its constant part is `−ν u_{i,jj}` (the
derivative fields `u_{i,j}`, `u_{i,jj}` are independent canonical coordinates, constants
of the motion at the fiber).  So the full quadratic symbol is exactly the affine field
`V_i` above with `A = G` and `c_i = −ν u_{i,jj}`, and the canonical quantization of the
symbol is the Weyl-ordered `∑_i ½(π_i A_i + A_i π_i)`.

## Contents

* `ann i`, `cre i` — the annihilation and creation operators of the `i`-th mode on the
  finite-mode core of `ℓ²(Vel)`, with the full canonical commutation relations
  `comm_ann_cre` (`[a_i, a_i†] = 1`), `comm_ann_cre_of_ne` (`[a_i, a_k†] = 0`, `i ≠ k`),
  `ann_comm`, `cre_comm`;
* `pos i = (a_i + a_i†)/√2`, `mom i = i(a_i† − a_i)/√2` — the three canonical pairs, with
  `comm_mom_pos` (`[π_i, u_i] = −i`) and `comm_mom_pos_of_ne` (`[π_i, u_k] = 0`);
* `fieldV A c i = ∑_k A_{ik} u_k + c_i` — the affine fiber field, and
  `canH A c = ∑_i ½(π_i V_i + V_i π_i)` — the Weyl-ordered canonical Hamiltonian;
* `canH_eq_velH` — **the identification**: `canH A c` is exactly the Hermite matrix
  `velH A c` of `ChapterNavierStokesThreeComponent`;
* `canH_essentiallySelfAdjointOn_core` — hence the canonically written full
  quadratic-symbol Hamiltonian is essentially self-adjoint on the finite-mode core;
* `nsQuadraticH`, `nsQuadraticH_essentiallySelfAdjointOn_core` — the same statement with
  the coefficients spelled out as the Navier–Stokes data `(ν, u_{i,j}, u_{i,jj})`.

## Honest boundary

The Hilbert space is the Hermite (occupation-number) realization `ℓ²(Fin 3 → ℕ)` of
`L²(du₁du₂du₃)` for the three velocity components at one fiber; `pos i` and `mom i` are
the canonical pair in that realization, and the operator is the Weyl quantization of the
affine symbol.  Nothing here claims global regularity of the classical Navier–Stokes
equation (Contention D5, the deliberate scope cut).
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace CanonicalVector

open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

/-! ## Bookkeeping for the multi-index shifts -/





@[simp] theorem lower_raise (i : Fin 3) (β : Vel) : lower i (raise i β) = β := by
  funext j
  by_cases hji : j = i
  · subst hji; rw [lower_self, raise_self]; omega
  · rw [lower_of_ne hji, raise_of_ne hji]

theorem raise_lower (i : Fin 3) {β : Vel} (h : 1 ≤ β i) : raise i (lower i β) = β := by
  funext j
  by_cases hji : j = i
  · subst hji; rw [raise_self, lower_self]; omega
  · rw [raise_of_ne hji, lower_of_ne hji]



/-! ## The ladder operators of the three modes -/

/-- The coordinates of `a_i x`: `√(β_i + 1) x_{β + e_i}`. -/
noncomputable def aFun (i : Fin 3) (X : Vel → ℂ) : Vel → ℂ :=
  fun β => (Real.sqrt ((β i : ℝ) + 1) : ℂ) * X (raise i β)

/-- The coordinates of `a_i† x`: `√(β_i) x_{β − e_i}`. -/
noncomputable def cFun (i : Fin 3) (X : Vel → ℂ) : Vel → ℂ :=
  fun β => (Real.sqrt (β i : ℝ) : ℂ) * X (lower i β)

theorem support_aFun {i : Fin 3} {X : Vel → ℂ} (h : (Function.support X).Finite) :
    (Function.support (aFun i X)).Finite := by
  refine Set.Finite.subset (h.preimage (f := raise i)
    (Set.injOn_of_injective (raise_injective i))) ?_
  intro β hβ
  simp only [Function.mem_support, aFun] at hβ
  simp only [Set.mem_preimage, Function.mem_support]
  intro h0
  exact hβ (by rw [h0, mul_zero])

theorem support_cFun {i : Fin 3} {X : Vel → ℂ} (h : (Function.support X).Finite) :
    (Function.support (cFun i X)).Finite := by
  refine Set.Finite.subset (h.image (raise i)) ?_
  intro β hβ
  simp only [Function.mem_support, cFun] at hβ
  have hne : X (lower i β) ≠ 0 := fun h0 => hβ (by rw [h0, mul_zero])
  have hpos : 1 ≤ β i := by
    by_contra hcon
    have : β i = 0 := by omega
    apply hβ
    rw [this]
    simp
  exact ⟨lower i β, hne, raise_lower i hpos⟩

/-- A finitely supported coordinate sequence as a state of the finite-mode core. -/
noncomputable def mkCore {X : Vel → ℂ} (h : (Function.support X).Finite) : lpFiniteModes Vel :=
  ⟨⟨X, memLpTwo_of_finite_support h⟩, h⟩

@[simp] theorem mkCore_coe {X : Vel → ℂ} (h : (Function.support X).Finite) (β : Vel) :
    (((mkCore h : lpFiniteModes Vel) : L2I Vel) : Vel → ℂ) β = X β := rfl

theorem support_finite (x : lpFiniteModes Vel) :
    (Function.support (((x : L2I Vel) : Vel → ℂ))).Finite := x.2

/-- **The annihilation operator of the mode `i`.** -/
noncomputable def ann (i : Fin 3) : lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel where
  toFun x := mkCore (support_aFun (i := i) (support_finite x))
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun β => ?_))
    simp only [mkCore_coe, aFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun β => ?_))
    simp only [mkCore_coe, aFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring

/-- **The creation operator of the mode `i`.** -/
noncomputable def cre (i : Fin 3) : lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel where
  toFun x := mkCore (support_cFun (i := i) (support_finite x))
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun β => ?_))
    simp only [mkCore_coe, cFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun β => ?_))
    simp only [mkCore_coe, cFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring















/-! ## The canonical commutation relations, at the level of coordinates -/























/-! ## The canonical commutation relations, as operator identities -/









/-! ## The three canonical pairs -/



/-- **The fiber coordinate of the mode `i`**, `u_i = (a_i + a_i†)/√2`. -/
noncomputable def pos (i : Fin 3) : lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel :=
  ((1 / Real.sqrt 2 : ℝ) : ℂ) • (cre i + ann i)

/-- **The momentum of the mode `i`**, `π_i = i(a_i† − a_i)/√2 = −i ∂/∂u_i`. -/
noncomputable def mom (i : Fin 3) : lpFiniteModes Vel →ₗ[ℂ] lpFiniteModes Vel :=
  (Complex.I * ((1 / Real.sqrt 2 : ℝ) : ℂ)) • (cre i - ann i)





/-! ## The coordinates of a signed hop, read off from an incoming term

For each of the four hopping families of `ChapterNavierStokesThreeComponent` the
"incoming" half of the hopping — the value of the Hamiltonian at `γ` coming from the
unique index that hops to `γ` — is a ladder expression, and the following lemma is the
bookkeeping that identifies it as such. -/



variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

/-! ### The diagonal (self-advection) hop -/



/-! ### The strain (symmetric cross) hop -/



/-! ### The vorticity (antisymmetric cross) hop -/



/-! ### The `±1`-hop of the constant part -/



/-! ## The ladder normal form

Both the Hermite matrix `velH` and the canonically written operator reduce to the same
explicit combination of ladder expressions; `ladFun` is that combination. -/







/-! ## The canonically written Hamiltonian -/

























/-! ### The Weyl-ordered product of one momentum and one coordinate -/













/-! ## The identification, and essential self-adjointness of the canonical operator -/









/-! ## The Navier–Stokes reading of the coefficients

At one Eulerian fiber the quadratic symbol of the Navier–Stokes generator is
`A_i(u) = u_j u_{i,j} − ν u_{i,jj}`, an affine function of the velocity whose linear part
is the velocity gradient `u_{i,j}` and whose constant part is `−ν u_{i,jj}` (the derivative
fields are independent canonical coordinates at the fiber).  The following is the theorem
above with the coefficients spelled out that way. -/







end CanonicalVector

end BookProof.NavierStokesFlow



/-!
# Chapter "The Coherent State of Attention", §"The Posterior: Observable
Operators and Expectation Values" — the observable as an **operator**

`BookProof.ChapterObservableExpectation` proves the expectation-value identity
using only the *spectral data* of the observable (its eigenvalues `vⱼ` indexed by
the outcomes) and records the disparity with the informal chapter, which writes
the observable as the operator

  `V̂ = ∑ⱼ vⱼ |kⱼ⟩⟨kⱼ|`

and appeals to the spectral theorem.  This module closes that disparity by
building the operator itself, in finite dimensions, as a matrix:

* `outerProj k` — the rank-one operator `|k⟩⟨k|`;
* `observableOp k v` — the observable `V̂ = ∑ⱼ vⱼ |kⱼ⟩⟨kⱼ|` with real eigenvalues;
* `observableOp_isHermitian` — **`V̂` is Hermitian** (a genuine observable);
* `bornProb` — the Born statistics `pⱼ = |⟨kⱼ|q⟩|²` of measuring `V̂` in the state
  `|q⟩`, with `bornProb_nonneg` and (for an orthonormal eigenbasis and a unit
  state) `bornProb_sum_one`;
* `expectation_outerProj`, **`observableOp_expectation`** — the operator
  expectation `⟨q|V̂|q⟩` is the Born-weighted sum `∑ⱼ pⱼ vⱼ` of the eigenvalues,
  i.e. exactly `ChapterObservableExpectation.observableExpectation`;
* `observableOp_expectation_mem_convexHull` — hence, for an orthonormal
  eigenbasis and a unit state, the expectation lies in the convex hull of the
  eigenvalues;
* `observableOp_expectation_real` — the expectation of a Hermitian observable is
  real.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterObservableOperator

variable {n m : ℕ}

/-! ## The observable operator -/









/-! ## Expectation values -/

/-- The **expectation value** `⟨q| A |q⟩` of a matrix observable in the state
`|q⟩`. -/
def expectation (A : Matrix (Fin n) (Fin n) ℂ) (q : EuclideanSpace ℂ (Fin n)) : ℂ :=
  ∑ a, ∑ b, (starRingEnd ℂ) (q a) * A a b * q b











/-! ## An orthonormal eigenbasis makes the Born statistics a probability law -/







end BookProof.ChapterObservableOperator

end



/-!
# Chapter "On the physical parity transformation and antiparticles" — the finite algebraic core

This file formalizes the self-contained, finite-dimensional algebraic content of the
`book.tex` chapter *"On the physical parity transformation and antiparticles"*
(`book.tex` line ~7522).  The chapter's central physical thesis — that at the quantum
level all fields are **real representations** (self-adjoint operators), so that CP and
P coincide and the (generalized) parity transformation is **order four** — rests on a
handful of concrete linear-algebra facts, which are what we discharge here.

The surrounding physical modelling (canonical quantization of a real Hilbert space, the
Standard-Model Lagrangian, path-integral measures) is left as prose.

Deliverable groups:

* **Hermitian decomposition of a field.** *"Any non-Hermitian field can always be
  decomposed into a sum of two Hermitian fields"* (Lee–Wick, quoted in the chapter):
  every square complex matrix `X` is `A + i B` with `A`, `B` Hermitian.
* **The Higgs (generalized) parity is order four.** The internal part of the Higgs
  parity transformation `φ ↦ i σ₂ φ` is `i σ₂`, which satisfies `(i σ₂)² = -1` and hence
  `(i σ₂)⁴ = 1` while `(i σ₂)² ≠ 1`: the parity is a genuine `ℤ₄` (order-4) symmetry.
* **The fermion parity operator `i γ⁰` is order four ⇒ the double cover is `Pin(3,1)`.**
  On Majorana spinors the parity acts through `i γ⁰ = mgamma 0` of the concrete `A3`
  model; `(i γ⁰)² = -1` (order four), in contrast to the naive Dirac `γ⁰` for which
  `(γ⁰)² = +1`.  This `-1` is exactly the invariant distinguishing `Pin(3,1)` from
  `Pin(1,3)`.
* **The Gell-Mann outer-automorphism signs.** The complex conjugation of the eight
  `SU(3)` Gell-Mann matrices realizes the `ℤ₂` outer automorphism with the sign pattern
  the chapter uses for the parity transformation of the gluon fields: the real
  generators (`λ¹, λ³, λ⁴, λ⁶, λ⁸`) are fixed and the imaginary ones (`λ², λ⁵, λ⁷`) are
  negated.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterParity

/-! ## 1. Hermitian decomposition of an arbitrary field -/

variable {n : Type*}











/-! ## 2. The Higgs (generalized) parity `i σ₂` is order four -/

/-- The Pauli matrix `σ₂`. -/
noncomputable def pauli2 : Matrix (Fin 2) (Fin 2) ℂ := !![0, -Complex.I; Complex.I, 0]











/-! ## 3. The fermion parity `i γ⁰` is order four ⇒ the double cover is `Pin(3,1)` -/








/-! ## 4. The Gell-Mann matrices and the outer-automorphism (parity) signs -/









end BookProof.ChapterParity



/-!
# Chapter "Wave-function collapse versus Euler's formula", §"Euler's formula for
the probability clock" — stochastic transformations vs. the invertible rotation

Source: `book.tex`, chapter *"Wave-function collapse versus Euler's formula"*,
§*"Euler's formula for the probability clock"* (`book.tex` line ~3320).

After exhibiting the wave-function `Ψ(t) = (cos t, sin t)` and its rotation
`Ψ(t+a) = exp(J a) Ψ(t)`, the book contrasts the *wave-function* picture with a
*direct* linear action on **probability distributions**:

> *"Note that the rotation is an invertible linear transformation that
> preserves the space of wave-functions. This does not happen with probability
> distributions: the most general linear transformation of a probability
> distribution that preserves the space of probability distributions is*
> `M(a,b) = [[cos²a, cos²b], [sin²a, sin²b]]` *… because if we apply `M` to a
> deterministic distribution `[1,0]` or `[0,1]` we must obtain probability
> distributions … the matrix `M` such that `M·(1/2)[1,1]ᵀ = [1,0]ᵀ` is
> necessarily singular and so it is not suitable to represent a symmetry group."*

This file formalizes that self-contained linear-algebra content for the 2-state
phase space.

## Deliverables

* **General form / column-stochastic matrices.**
  * `Mab a b` — the book's matrix `[[cos²a, cos²b], [sin²a, sin²b]]`;
    `Mab_isColumnStochastic` — its columns are probability vectors.
  * `IsColumnStochastic.mulVec_isProbabilityVector` — a column-stochastic matrix
    maps probability vectors to probability vectors.
  * `preserves_prob_iff_isColumnStochastic` — a `2×2` real matrix maps *every*
    probability vector to a probability vector **iff** it is column-stochastic
    (the honest form of "the most general linear transformation preserving the
    space of probability distributions").
  * `isColumnStochastic_eq_Mab` — every column-stochastic `2×2` matrix is
    `Mab a b` for some real `a, b` (so `M(a,b)` really is the general form).

* **The book's singularity point (headline).**
  * `stochastic_uniform_to_deterministic_singular` — if a column-stochastic
    matrix `M` sends the uniform distribution `(1/2, 1/2)` to a deterministic
    distribution `(1, 0)`, then `det M = 0`.
  * `stochastic_uniform_to_deterministic_not_isUnit` — consequently `M` is not
    invertible, hence "not suitable to represent a symmetry group".

* **Contrast: the rotation is a genuine (invertible) symmetry.**
  * `rotMat a` — the rotation `[[cos a, -sin a], [sin a, cos a]]`;
    `rotMat_det` (`= 1`, invertible), `rotMat_isUnit`.
  * `clockPsi` `= (cos t, sin t)` and `rotMat_mulVec_clockPsi`
    (`Ψ(t+a) = rotMat a · Ψ(t)`) — the rotation preserves the wave-function
    circle.
  * `rotMat_eq_exp` — `rotMat a = exp(a·J)` with `J = [[0,-1],[1,0]]`, the
    matrix Euler's formula, and `clockPsi_eq_exp` — `Ψ(t) = exp(t·J)·(1,0)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ProbabilityClockStochastic

open Matrix
open scoped Norms.Operator

/-! ## Probability vectors and column-stochastic matrices -/

















/-! ## The book's singularity point -/





/-! ## Contrast: the rotation is a genuine invertible symmetry -/





/-- The rotation matrix `[[cos a, -sin a], [sin a, cos a]]`. -/
noncomputable def rotMat (a : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos a, -Real.sin a; Real.sin a, Real.cos a]













end BookProof.ProbabilityClockStochastic



/-!
# Riesz–Fischer for the PA-free completion: the finitely-supported core in `ℓ²(ℕ)`

`BookProof/ChapterPaFreeCompletion.lean` and `BookProof/ChapterDefinabilityFragment.lean`
describe the "PA-free completion" architecture: the *dense core* of term-denotable
vectors is the space `ℕ →₀ ℝ` of finitely-supported sequences, and the ambient
Hilbert space is its completion `ℓ²(ℕ)`.  Those two files record the
finite-support side of the story; the analytic side (the actual Riesz–Fischer
content) is proved here.

The three facts that make the architecture precise are:

* **completeness** (`ell2_completeSpace`): `ℓ²(ℕ)` is a Hilbert space, so no
  Cauchy sequence of core vectors escapes it;
* **Riesz–Fischer / density** (`riesz_fischer_hasSum`, `finSupport_dense`): every
  vector of `ℓ²(ℕ)` is the norm-limit of its finitely-supported truncations, so
  the completion adds *only* limit points of the core;
* **properness** (`finSupport_ne_univ`): the completion is strictly larger than
  the core — the geometric vector `n ↦ 2⁻ⁿ` lies in `ℓ²(ℕ)` and has infinite
  support — so the passage to the completion is not vacuous.

Together these say exactly what the chapter claims: the completion is the
smallest Hilbert space containing the finitely-supported core, and every one of
its elements is approximated to arbitrary precision by core elements.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Filter
open scoped ENNReal

namespace BookProof.ChapterRieszFischer

/-- The real sequence space `ℓ²(ℕ)`: the completion of the finitely-supported
core `ℕ →₀ ℝ`. -/
abbrev Ell2 := lp (fun _ : ℕ => ℝ) 2





















end BookProof.ChapterRieszFischer



/-!
# The Simader–Faris–Lavine cutoff method for `-d²/dx² + V`

This module carries out, in one space dimension and with no unproved input, the
**cutoff / commutator energy argument** for essential self-adjointness of a
Schrödinger operator `H = -Δ + V` with a potential that is allowed to grow
arbitrarily fast — the motivating example being the non-polynomial
`V(x) = eˣ + e⁻ˣ`, for which none of the polynomial-growth criteria apply.

The mathematical content is the classical energy estimate: if `u` is a
square-integrable classical solution of `-u'' + V u = z u` with
`Re z + 1 ≤ V` pointwise, then testing the equation against `χ_R² ū`,
integrating by parts once, and absorbing the cross term by Young's inequality
gives

  `∫_{[-R,R]} |u|² ≤ ∫ χ_R² (V - Re z) |u|² ≤ (2C²/R²) ‖u‖²_{L²}`,

where `C` bounds `|χ'|` for a fixed smooth cutoff `χ` equal to `1` on `[-1,1]`
and supported in `[-2,2]`, and `χ_R(x) = χ(x/R)`.  Letting `R → ∞` forces
`u = 0`.  Applied to `z = ± i` — whose real part is `0`, so that the hypothesis
`Re z + 1 ≤ V` only asks `V ≥ 1` — this says exactly that the classical
deficiency spaces of `H` are trivial, which is the analytic heart of essential
self-adjointness.

## Contents

* `integral_deriv_eq_zero_of_hasCompactSupport` — the one-dimensional
  integration-by-parts engine: the integral over `ℝ` of the derivative of a
  compactly supported `C¹` function vanishes.
* The section "the cutoff family" — a concrete smooth cutoff `chi` built from
  Mathlib's `ContDiffBump`, its basic properties, the gradient bound
  `exists_deriv_chi_bound`, and the rescaled family `exists_scaled_cutoff`
  (Milestone 3 of the plan: `|χ_R'| ≤ C/R`).
* `hasDerivAt_reInner` — the derivative of the energy density
  `x ↦ Re(conj (u x) · u'(x))`.
* `schrodingerOp`, `integral_conj_secondDeriv_comm` and `schrodingerOp_symmetric`
  — Milestone 2: the operator `H f = -f'' + V f` on the compactly supported
  twice differentiable core, and its Hermitian symmetry there, for an arbitrary
  real continuous `V` (no growth restriction).
* `cutoff_energy_core` — Milestone 4 in its sharpest form: under the weaker
  hypothesis `Re z ≤ V` it bounds *both* the potential energy
  `∫_{[-R,R]} (V - Re z)|u|²` and the Dirichlet energy `∫_{[-R,R]} |u'|²` by a
  multiple of `‖u‖²_{L²}/R²`.
* `cutoff_energy_estimate` — Milestone 4: the estimate displayed above, for an
  arbitrary continuous `V` and arbitrary `z` with `Re z + 1 ≤ V`.
* `l2_classical_solution_eq_zero` — Milestone 5: the limit `R → ∞`, giving
  `u = 0`.
* `l2_classical_solution_eq_zero_of_nonneg` — the same conclusion under the
  weaker hypothesis `Re z ≤ V`, obtained by running the limit on the Dirichlet
  term instead: `u' ≡ 0`, so `u` is constant, and a constant in `L²(ℝ)` is `0`.
* `laplacian_deficiency_trivial` / `..._I` / `..._negI` — the `V = 0`
  specialisation: the free Laplacian `-d²/dx²` on the line has no nonzero
  square-integrable classical solution of `-u'' = z u` when `Re z ≤ 0`, in
  particular for `z = ± i`.
* `Vexp`, `two_le_Vexp` and `schrodinger_exp_deficiency_trivial` /
  `schrodinger_exp_deficiency_trivial_I` / `..._negI` — the motivating
  application: for `V(x) = eˣ + e⁻ˣ` the operator `-d²/dx² + V` has no nonzero
  square-integrable classical solution of `H u = ± i u`.

Nothing here is assumed: the module contains no `axiom` and no `sorry`.
-/

namespace BookProof.SchrodingerCutoff

open MeasureTheory Filter Complex

/-! ## Integration by parts on the line -/

/-- The integral over `ℝ` of the derivative of a compactly supported `C¹`
function is zero.  This is the only integration-by-parts input of the whole
argument. -/
theorem integral_deriv_eq_zero_of_hasCompactSupport
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E]
    {g g' : ℝ → E} (h : ∀ x, HasDerivAt g (g' x) x) (hc : Continuous g')
    (hs : HasCompactSupport g) : ∫ x, g' x = 0 := by
  obtain ⟨M, hMpos, hM⟩ := hs.exists_pos_le_norm
  have hvanish : ∀ x : ℝ, M < |x| → g' x = 0 := by
    intro x hx
    have hnb : g =ᶠ[nhds x] fun _ => (0 : E) := by
      filter_upwards [(isOpen_lt continuous_const continuous_abs).mem_nhds hx] with y hy
      exact hM y (le_of_lt hy)
    exact (h x).unique ((hasDerivAt_const x (0 : E)).congr_of_eventuallyEq hnb)
  have hsub : ∫ x, g' x = ∫ x in Set.Ioc (-(M + 1)) (M + 1), g' x := by
    rw [setIntegral_eq_integral_of_forall_compl_eq_zero]
    intro x hx
    refine hvanish x ?_
    simp only [Set.mem_Ioc, not_and_or, not_lt, not_le] at hx
    rcases hx with hx | hx
    · rw [abs_of_nonpos (by linarith)]; linarith
    · rw [abs_of_pos (by linarith)]; linarith
  rw [hsub, ← intervalIntegral.integral_of_le (by linarith)]
  rw [show (fun x => g' x) = deriv g from funext fun x => ((h x).deriv).symm]
  rw [intervalIntegral.integral_deriv_eq_sub (fun x _ => (h x).differentiableAt)
      (by rw [show deriv g = g' from funext fun x => (h x).deriv]
          exact hc.intervalIntegrable _ _)]
  rw [hM (M + 1) (by rw [Real.norm_eq_abs, abs_of_pos (by linarith)]; linarith),
      hM (-(M + 1)) (by rw [Real.norm_eq_abs, abs_of_nonpos (by linarith)]; linarith)]
  simp

/-! ## The cutoff family -/



























/-! ## The derivative of the energy density -/



/-! ## Milestone 4: the cutoff energy estimate -/





/-! ## Milestone 5: the limit `R → ∞` -/













/-! ## Milestone 2: the operator on the smooth compactly supported core -/









/-! ## The exponential potential -/













end BookProof.SchrodingerCutoff



/-!
# Chapter SirkFinitePrecision — the finite-precision certificate layer (T1–T5)

`CONSOLIDATED_PLAN.md` §13.3, `MASS_GAP_CERTIFIED.md` §4: the SIRK/Hashimoto
reliability chain of §12 is stated in *exact* arithmetic, while the kernel runs in
`f64`.  This chapter formalises the layers that turn a computed number into a
*rigorous enclosure*, with every constant explicit.  Nothing here trusts a
floating-point value: the theorems consume only residuals, backward-error bounds and
interval enclosures, all of which enter as hypotheses or as certified data.

## Deliverables

* `HasRealEigenvalue` — a real eigenvalue of an operator; `rayleigh` — the Rayleigh
  quotient `re ⟪x, T x⟫`, the quantity the kernel reports as a Ritz value.
* The spectral expansion of a symmetric operator in its eigenbasis
  (`repr_apply_of_symmetric`, `norm_sq_eq_sum_repr`, `rayleigh_eq_sum_eigenvalues`,
  `norm_apply_sq_eq_sum_eigenvalues`).
* **T2 (Rayleigh–Ritz residual bound, Layer 3, §4.3)**
  `exists_eigenvalue_dist_le_residual` / `exists_eigenvalue_dist_le_residual_unit`:
  for *any* vector `x ≠ 0` and any real `θ` there is an eigenvalue `lam` of the
  exact operator with `|lam − θ| · ‖x‖ ≤ ‖T x − θ x‖`.  This is Parlett's
  a-posteriori bound: it applies to the *computed* vector and the *exact* operator,
  so no infinite-precision hypothesis is needed at the theorem level.
* **T1/T3 (backward error + Weyl, Layer 1, §4.1)** `backward_error_weyl` and
  `backward_error_weyl_symm`: if the computed eigenpairs are exact eigenpairs of a
  perturbed operator `S` with `‖T x − S x‖ ≤ ε ‖x‖` (the LAPACK backward-error
  model, `ε = c(n) · u · ‖Ĝ‖`), then the eigenvalues of `S` and of `T` are within
  `ε` of each other.  This is Weyl's inequality in the enclosure (Hausdorff) form —
  the form the certificate consumes.
* **The Rayleigh–Ritz upper bound** `ground_le_rayleigh`: the lowest eigenvalue
  never exceeds a computed Rayleigh quotient — the direction that is
  unconditionally sound.
* **Temple's inequality** `temple_lower_bound`: the rigorous *lower* bound for the
  lowest eigenvalue from a computed Rayleigh quotient and an a-priori separation
  constant `β`.  (The bound `λ₀ ≥ θ − ‖r‖` used informally in
  `MASS_GAP_CERTIFIED.md` §3.4 step 1 is *not* valid without extra information — a
  small residual only certifies that *some* eigenvalue is near `θ`.  Temple's
  inequality and `ground_ge_of_no_eigenvalue_below` are the two honest
  replacements, and they are what `ChapterSirkCertifiedGap` uses.)
* **T4 (certified-observable propagation, §5.2)** `observable_propagation`:
  `|⟨O⟩_u − ⟨O⟩_w| ≤ ‖O‖ (‖u‖ + ‖w‖) ‖u − w‖`, and the `2‖O‖ · band · ‖v‖` form
  `observable_propagation_band`.
* **T5 (the interval-enclosure core, Layer 2, §4.2/§4.4)** `CertInterval` with
  `add`/`neg`/`sub`/`mul`/`widen` and their soundness theorems
  (`mem_add`, `mem_neg`, `mem_sub`, `mem_mul`, `mem_widen`), the outward-rounding
  model `mem_ofRounded`, the certified supremum `le_sup_bound_of_isotone` /
  `abs_le_of_isotone`, and the half-width extraction `dist_le_width`.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

namespace BookProof.SirkFinitePrecision

open scoped InnerProductSpace
open Finset

variable {n : ℕ} {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [FiniteDimensional ℂ E]

/-! ## 0. Eigenvalues and Rayleigh quotients -/





/-- The `i`-th coordinate of `x` in the eigenbasis of the symmetric operator `T`. -/
def coeff {T : E →ₗ[ℂ] E} (hT : T.IsSymmetric) (hn : Module.finrank ℂ E = n) (x : E)
    (i : Fin n) : ℂ :=
  ((hT.eigenvectorBasis hn).repr x).ofLp i

/-! ## 1. The spectral expansion of a symmetric operator -/













/-! ## 2. T2 — the Rayleigh–Ritz (Parlett/Weinstein) residual bound -/





/-! ## 3. T1/T3 — backward error of the eigendecomposition, and Weyl -/





/-! ## 4. The two-sided a-posteriori bracket for the lowest eigenvalue -/







/-! ## 5. T4 — certified propagation to observables -/





/-! ## 6. T5 — the interval-enclosure core

The only new *trusted* component of the certificate architecture is the
directed-rounding interval layer.  Here it is: a two-sided enclosure type, the
soundness of its arithmetic, an explicit outward-rounding model (a computed endpoint
pair is admissible as soon as it brackets the exact value, which is exactly what
directed rounding guarantees), and the two consequences the mass-gap certificate
uses — a certified supremum over a box from an inclusion-isotone extension, and the
extraction of a certified half-width from an enclosure. -/

/-- A closed real interval, used as an enclosure. -/
structure CertInterval where
  /-- The (rounded-down) lower endpoint. -/
  lo : ℝ
  /-- The (rounded-up) upper endpoint. -/
  hi : ℝ

namespace CertInterval







/-- Interval addition. -/
def add (I J : CertInterval) : CertInterval := ⟨I.lo + J.lo, I.hi + J.hi⟩



/-- Interval subtraction. -/
def sub (I J : CertInterval) : CertInterval := ⟨I.lo - J.hi, I.hi - J.lo⟩

/-- Interval multiplication (the four-corner rule). -/
def mul (I J : CertInterval) : CertInterval :=
  ⟨min (min (I.lo * J.lo) (I.lo * J.hi)) (min (I.hi * J.lo) (I.hi * J.hi)),
   max (max (I.lo * J.lo) (I.lo * J.hi)) (max (I.hi * J.lo) (I.hi * J.hi))⟩





































end CertInterval

end BookProof.SirkFinitePrecision



/-!
# Chapter SirkRitzPerturbation — the min–max levels are 1-Lipschitz, and a gap survives a
perturbation

`BookProof.ChapterSirkRitzMinMax` built the Courant–Fischer levels `minmaxLevel T k` of a
bounded operator and proved that the Galerkin (Rayleigh–Ritz) levels of the truncations
converge to them, so that the *computed* gap converges to the min–max gap.  That statement
is about **one** operator: the exact one.  A solver never holds the exact operator — it
holds a model of it (a truncated coupling, a rounded matrix, a regularized potential).
`CONSOLIDATED_PLAN.md` §12.2 Gap 2 and §13 therefore need the *stability* half: how far can
the levels move when the operator moves?

This chapter answers that: **every Courant–Fischer level is 1-Lipschitz in the operator
norm**, so the gap is 2-Lipschitz, and a gap that exceeds twice the modelling error is a
genuine gap of the exact operator.

## Deliverables

* `rayleighVal_sub_le_dist`, `abs_rayleighVal_sub_le_dist`, `rayleighSup_le_rayleighSup_add`,
  `abs_rayleighSup_sub_le_dist` — the elementary layer: on the unit sphere the Rayleigh
  quotients, and hence the tops of the numerical ranges on any subspace, move by at most
  `‖T − T'‖`.
* `minmaxSet_nonempty_congr` / `minmaxSetIn_nonempty_congr` — the min–max sets are nonempty
  for one operator iff for all of them: nonemptiness is a statement about the *dimensions*
  available in the space, not about the operator.
* **`abs_minmaxLevel_sub_le_dist`** — the headline: `|Λ_k(T) − Λ_k(T')| ≤ ‖T − T'‖`.
* **`abs_minmaxLevelIn_sub_le_dist`** — the same for the Ritz levels computed inside a fixed
  truncation `W`, and **`minmaxLevel_le_minmaxLevelIn_add`**: a Ritz level computed in `W`
  for the *model* operator is an upper bound for the exact level of the true operator, up to
  the operator error.  This is the form a certificate takes.
* `minmaxLevel_mono_form` — monotonicity in the form order, `minmaxLevel_le_norm` /
  `neg_norm_le_minmaxLevel` — the levels lie in `[−‖T‖, ‖T‖]`.
* `shiftOp`, `rayleighVal_shiftOp`, `rayleighSup_shiftOp`, **`minmaxLevel_shiftOp`** — a real
  shift shifts every level, `Λ_k(T + c) = Λ_k(T) + c`, hence **`minmaxGap_shiftOp`**: the gap
  is invariant under the shift a shift-invert scheme applies.
* `minmaxGap`, `minmaxGap_nonneg`, `abs_minmaxGap_sub_le` — the gap and its 2-Lipschitz
  bound; **`minmaxGap_ge_of_dist_le`** and **`minmaxGap_pos_of_dist_lt`**: a gap survives a
  perturbation of less than half its size.
* **`minmaxLevel_tendsto_of_tendsto`** / `minmaxGap_tendsto_of_tendsto` — norm convergence of
  a family of operators forces convergence of every level, and of the gap.
* **`galerkin_model_gap_tendsto`** — what a solver running on the model operator computes:
  its Galerkin gaps converge, and the limit is within `2ε` of the true gap.
* **`galerkin_model_gap_eventually_pos`** — a true gap larger than twice the modelling error
  is eventually seen by the truncations of the model operator.
* **`abs_sInf_spectrum_sub_le_dist`** — through the level-zero identification of
  `ChapterSirkRitzMinMax`, the bottom of the spectrum of a bounded self-adjoint operator is
  1-Lipschitz in the operator norm.

## Honest boundary

Everything here is for **bounded** operators, and the distance used is the operator norm: a
perturbation that is only relatively bounded, or only strongly convergent, is not covered.
The certified direction is the one the variational principle gives: computed Ritz levels are
**upper** bounds.  Nothing here turns a positive *computed* truncated gap into a positive
gap of the exact operator — that needs a lower bound on the first excited level (a residual
estimate), not merely the min–max inequality; `galerkin_model_gap_eventually_pos` runs in
the sound direction, from a true gap to what the truncations of the model eventually show.
-/

noncomputable section

namespace BookProof.RitzPerturbation

open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]









/-! ## The min–max levels are 1-Lipschitz -/















/-! ## The order on the forms -/



/-! ## The gap -/









/-- The real shift `T + c` of a bounded operator. -/
def shiftOp (T : F →L[ℂ] F) (c : ℝ) : F →L[ℂ] F :=
  T + (c : ℂ) • ContinuousLinearMap.id ℂ F






















/-! ## What a solver running on the model operator computes -/





end BookProof.RitzPerturbation



/-!
# Chapter TempleSeparationNecessary — the spectral-separation input cannot be removed

`ChapterRitzCertificate` derives the per-order finite certificate from Temple's inequality,
whose one non-computational input is the spectral separation

  `SpectralSeparation A l b`  —  `l ≤ b` and every spectral point is `l` or `≥ b`.

`CONSOLIDATED_PLAN.md` records this as the remaining side condition of the certificate
route.  This chapter shows that it is a *genuine* side condition and not an artifact of the
proof: **no** bound on the spectral edge in terms of the Rayleigh quotient and residual of a
trial vector can hold without it.

`separation_necessary` exhibits, for every `M`, a bounded self-adjoint operator on a
two-dimensional Hilbert space and a unit trial vector whose Rayleigh quotient and residual
are both `0` — the best possible finite data — while the bottom of the spectrum is at most
`−M`.  So the residual alone controls nothing: a trial vector can be an *exact* eigenvector
and still say nothing about how far below the spectrum extends.  Some a priori information
about the rest of the spectrum, which is exactly what `SpectralSeparation` supplies, must be
provided from outside the finite computation.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.TempleSeparationNecessary


/-- The two-dimensional witness space. -/
abbrev E2 := EuclideanSpace ℂ (Fin 2)

/-- The rank-one orthogonal projection onto `ℂ ∙ x`, for a unit vector `x`. -/
def proj (x : E2) : E2 →L[ℂ] E2 := (innerSL ℂ x).smulRight x



/-- The witness operator: `−M` on the orthogonal complement of `x`, and `0` on `ℂ ∙ x`. -/
def witness (M : ℝ) (x : E2) : E2 →L[ℂ] E2 :=
  ((-M : ℝ) : ℂ) • ((1 : E2 →L[ℂ] E2) - proj x)





/-- The trial vector: the first basis vector, an exact eigenvector of `witness M x` for the
eigenvalue `0`. -/
def trial : E2 := EuclideanSpace.single 0 (1 : ℂ)

/-- The vector orthogonal to the trial vector, an exact eigenvector for `−M`. -/
def other : E2 := EuclideanSpace.single 1 (1 : ℂ)











/-! ## The finite data are perfect, and say nothing -/





/-! ## Yet the spectrum reaches down to `−M` -/







end BookProof.TempleSeparationNecessary

end



/-!
# Chapter "Reconstructing the classical trajectory of any isolated quantum system"
— the density-matrix / trace form of the main result
*"Time translation is a stochastic process if and only if it is deterministic"*

This file formalizes the **literal density-matrix statement** of the section
*"Time translation is a stochastic process if and only if it is deterministic"*
(`book.tex` line ~2613), one of the book's stated *"main results"*.

The book reduces the existence of a group action of a Wigner symmetry group on the
probability distribution to the equality, for every pure state `ρ_g = |Ψ⟩⟨Ψ|`,
every outcome `A = a` (rank-one projection `P_a = |e_a⟩⟨e_a|`) and every unitary
`U`, of the two Born probabilities

* `tr(diag(ρ_g) · U P_a U†)` — the probability obtained if the state first
  *collapses* to its diagonal (classical) part and then the transformation acts, and
* `tr(ρ_g · U P_a U†)` — the probability obtained if the transformation acts on the
  full quantum state.

The book then observes this equality is equivalent to the vanishing of the
off-diagonal Born sum `∑_{k≠b} conj(U k a)·Ψ k·conj(Ψ b)·U b a`, which is in turn
equivalent to `U` being *deterministic* (each column has at most one nonzero
entry). The off-diagonal core `↔` determinism is already established in
`BookProof.ChapterReconstruct` (`offDiag_eq_zero_iff_isDeterministic`,
`offDiag_unit_iff`). This file supplies the missing **density-matrix layer**: it
identifies the two matrix traces with the full/collapsed Born sums, shows their
difference is exactly the off-diagonal sum, and packages the headline equivalence

    (∀ a Ψ, tr(diag(ρ Ψ) · U P_a U†) = tr(ρ Ψ · U P_a U†)) ↔ IsDeterministic U

both over all states and over pure states (`∑ ‖Ψ k‖² = 1`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped BigOperators
open Finset Matrix

namespace BookProof.ChapterTimeTranslation

variable {n : ℕ}





/-- The rank-one projection `P_a = |e_a⟩⟨e_a|` onto the basis outcome `a`. -/
def proj (a : Fin n) : Matrix (Fin n) (Fin n) ℂ :=
  Matrix.of fun i j => if i = a ∧ j = a then 1 else 0



/-
Entries of the measurement operator: `(U P_a U†) k l = U k a · conj(U l a)`.
-/


/-
The "full" Born probability is the trace of `ρ · M_a`; expanded it is the
double sum `∑_{i,k} conj(U i a)·Ψ i · conj(Ψ k)·U k a`.
-/


/-
The "collapsed" Born probability is the trace of `diag(ρ) · M_a`; expanded it
is the diagonal sum `∑_i |Ψ i|²·|U i a|²`.
-/








end BookProof.ChapterTimeTranslation



/-!
# One-dimensional distributional regularity: `u'' = c·u` in the weak sense

`CONSOLIDATED_PLAN.md` §10.6.1/§10.6.2 leaves one gap of the quantum-gravity chapter open:
the *exponentially growing* scalaron wall.  Every route the project has tried so far is a
perturbative one — Kato–Rellich on the Gauss–polynomial core, the Carleman flux criterion
on the Hermite lattice — and both are refuted or inapplicable for a wall that grows faster
than every polynomial (`BookProof/ChapterHermiteExpWall.lean`).

The classical route that *does* reach an arbitrarily fast growing **non-negative** potential
is not perturbative at all: a deficiency vector `u` of `−d²/dx² + V` solves the ordinary
differential equation `u'' = (V − z)u`, and a non-negative `V` makes `|u|²` convex — hence,
being integrable and non-negative, zero.  The step that has to be supplied before the ODE
argument can start is *regularity*: the deficiency vector is a priori only an `L²` function
and the equation it satisfies is a distributional one.

This module supplies exactly that step, in one variable, with no reference to the physics:

* `exists_antideriv` — a test function of vanishing integral is the derivative of a test
  function (the elementary fact that makes the du Bois-Reymond argument work);
* `ae_eq_const_of_integral_deriv_smul_eq_zero` — **du Bois-Reymond**: a locally integrable
  function orthogonal to the derivative of every test function is a.e. constant;
* `ae_eq_affine_of_integral_deriv2_smul_eq_zero` — the second-order version: orthogonal to
  every *second* derivative means a.e. affine;
* `integral_deriv_mul_indefiniteIntegral` — integration by parts against an indefinite
  integral of a merely locally integrable function (through Mathlib's
  `AbsolutelyContinuousOnInterval` calculus, since such a primitive is differentiable only
  almost everywhere);
* `exists_ae_eq_doubleAntideriv_add_affine` — the real-valued regularity theorem: a weak
  solution of `u'' = G` is a.e. the double antiderivative of `G` plus an affine function;
* **`exists_deriv2_of_weak_eq`** — the complex-valued statement in the form the Schrödinger
  argument consumes: if `u` is locally integrable, `c` is continuous and `∫ g'' u = ∫ g c u`
  for every real test function `g`, then `u` agrees almost everywhere with a genuinely twice
  differentiable `W` satisfying `W'' = c·W` *everywhere*.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.WeakSecondDeriv

open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

/-- A **test function** on the line: smooth and compactly supported. -/
def IsTestFun (g : ℝ → ℝ) : Prop :=
  ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g ∧ HasCompactSupport g

namespace IsTestFun

theorem contDiff {g : ℝ → ℝ} (h : IsTestFun g) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g := h.1

theorem hasCompactSupport {g : ℝ → ℝ} (h : IsTestFun g) : HasCompactSupport g := h.2

theorem continuous {g : ℝ → ℝ} (h : IsTestFun g) : Continuous g := h.contDiff.continuous

theorem differentiable {g : ℝ → ℝ} (h : IsTestFun g) : Differentiable ℝ g :=
  (contDiff_infty_iff_deriv.1 h.contDiff).1

/-- The derivative of a test function is a test function. -/
theorem deriv {g : ℝ → ℝ} (h : IsTestFun g) : IsTestFun (_root_.deriv g) :=
  ⟨(contDiff_infty_iff_deriv.1 h.contDiff).2, h.hasCompactSupport.deriv⟩

theorem integrable {g : ℝ → ℝ} (h : IsTestFun g) : Integrable g volume :=
  h.continuous.integrable_of_hasCompactSupport h.hasCompactSupport

theorem sub {f g : ℝ → ℝ} (h1 : IsTestFun f) (h2 : IsTestFun g) :
    IsTestFun (fun x => f x - g x) := ⟨h1.contDiff.sub h2.contDiff, h1.2.sub h2.2⟩

theorem const_mul {g : ℝ → ℝ} (h : IsTestFun g) (a : ℝ) : IsTestFun (fun x => a * g x) :=
  ⟨contDiff_const.mul h.contDiff, h.hasCompactSupport.mul_left⟩



end IsTestFun

/-! ## 1. Elementary facts about test functions -/

















/-! ## 2. The du Bois-Reymond lemmas -/

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]








/-! ## 3. Integration by parts against an indefinite integral -/







/-! ## 4. The real regularity theorem -/









/-! ## 5. Calculus for the double antiderivative -/









/-! ## 6. The complex regularity theorem -/



end

end BookProof.WeakSecondDeriv



/-!
# Chapter A, §A.1 — the real/complex subsystem correspondence (work-package N1)

This file supplies the *closed-subspace bookkeeping* that the roadmap
(`FORMALIZATION_ROADMAP.md`, §A.1, Props 11/12) identifies as "the main work" of
the real↔complex trichotomy.  Building on the complex inner-product
infrastructure of `BookProof/Complexification.lean` (the complexification
`Cx W` of a real Hilbert space, its canonical conjugation `Cx.cxConj`, and the
complexification `cxSystem` of a real system), we establish an order-preserving
**bijection**

  { subsystems of a real system `(M, W)` }
      ≃  { conjugation-invariant subsystems of `(M, Cx W)` }

given by `Y ↦ complexify Y` with inverse `X ↦ realPart X`.  Its immediate
consequence is the headline

  `irreducible_iff_no_conj_subsystem` :
    `(M, W)` is irreducible ⇔ the complexification `(M, Cx W)` has no proper
    non-trivial *conjugation-invariant* subsystem,

which is exactly the reduction of real irreducibility to the conjugation-stable
part of the complexified subspace lattice used throughout Props 11/12.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped RealInnerProductSpace
open BookProof.ChapterA

namespace BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

namespace Cx

/-! ### Continuity of the coordinate maps and the real embedding -/

/-- The real-part projection `Cx W → W` is Lipschitz (hence continuous). -/
lemma lipschitz_re : LipschitzWith 1 (Cx.re : Cx W → W) := by
  refine LipschitzWith.of_dist_le_mul (fun x y => ?_)
  simp only [NNReal.coe_one, one_mul, dist_eq_norm]
  calc ‖x.re - y.re‖ = ‖(x - y).re‖ := by rw [sub_re]
    _ ≤ ‖x - y‖ := norm_re_le _



lemma continuous_re : Continuous (Cx.re : Cx W → W) := lipschitz_re.continuous


/-- The real embedding `ofReal : W → Cx W` is an isometry (hence continuous). -/
lemma continuous_ofReal : Continuous (Cx.ofReal : W → Cx W) := by
  refine LipschitzWith.continuous (K := 1) ?_
  refine LipschitzWith.of_dist_le_mul (fun x y => ?_)
  simp only [NNReal.coe_one, one_mul, dist_eq_norm]
  have : ofReal x - ofReal y = ofReal (x - y) := by ext <;> simp
  rw [this]
  rw [← Real.sqrt_sq (norm_nonneg (ofReal (x - y))), ← Real.sqrt_sq (norm_nonneg (x - y))]
  rw [norm_sq]; simp





/-! ### The complexification of a real subspace and the real part of a complex one -/









/-! ### The two round-trips -/



/-
If a complex subspace `X` is invariant under the conjugation `cxConj`, then
`complexify (realPart X) = X`.
-/




/-! ### Extremal values -/









/-! ### `complexify` and `realPart` preserve subsystems -/

variable [CompleteSpace W]

/-
`complexify` sends a subsystem of `(M, W)` to a subsystem of `(M, Cx W)`.
-/


/-
`realPart` sends a subsystem of `(M, Cx W)` to a subsystem of `(M, W)`.
-/


end Cx

/-! ## Headline: irreducibility via the conjugation-invariant lattice -/

/-
**The real irreducibility criterion (§A.1, core of Props 11/12).**  A real
system `(M, W)` is irreducible **iff** its complexification `(M, Cx W)` has no
proper non-trivial *conjugation-invariant* subsystem.  This is the reduction of
real irreducibility to the `cxConj`-stable part of the complexified subspace
lattice, obtained from the order-preserving bijection
`Y ↦ complexify Y`, `X ↦ realPart X`.
-/


end BookProof.Complexification



/-!
# Reassembling the classification list (plan GAP-2, the final step)

The previous waves produced all the pieces of the manuscript's abelian
classification list and left exactly one step open: *reassembly* — rewriting a
classified summand as **one** of the five standard models.  This module performs it
for a Borel probability measure on the line.

Write `S` for the (countable) set of atoms of `μ`.  Then

* `L²(μ)` is the Hilbert sum of `L²(μ|S)` and `L²(μ|Sᶜ)`, and the two embeddings
  intertwine the multiplication operators
  (`ChapterLpRestrictSplit.isHilbertSum_splitEmbed`, `restrictEmbed_intertwines`);
* the first piece is *purely atomic*, so multiplication is **diagonal** in the
  orthonormal basis of normalised point masses (`ChapterAtomicDiagonalModel`);
* the second piece is *diffuse*; after normalising its mass
  (`ChapterLpScaleMeasure`) its distribution function gives a unitary with `L²[0,1]`
  carrying multiplication by `g` to multiplication by `g ∘ F`
  (`ChapterDiffuseUnitaryModel`).

Assembling these gives the headline `abelian_summand_standard_model`, and the
case distinction on `μ(S)`, `μ(Sᶜ)` and the cardinality of `S` gives the list itself,
`vonNeumann_abelian_classification_list`: every summand is `Iₙ`, `ℓ∞(ℕ)`, `L∞[0,1]`,
`L∞[0,1] ⊕ Iₙ` or `L∞[0,1] ⊕ ℓ∞(ℕ)`.

Everything is `sorry`-free and `axiom`-free.
-/

noncomputable section

open MeasureTheory ProbabilityTheory

namespace BookProof.ChapterAbelianClassificationList

open BookProof.ChapterLinftyMultiplication

/-! ## 1. The atomic piece is purely atomic -/

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]





/-! ## 2. Scaling preserves diffuseness -/



/-! ## 3. The diffuse piece is a copy of the unit interval -/

section Diffuse

variable (nu : Measure ℝ) [IsFiniteMeasure nu] [NoAtoms nu]

/-- The normalised diffuse measure: an atomless probability measure on the line. -/
def normalized : Measure ℝ := (nu Set.univ)⁻¹ • nu







end Diffuse

/-! ## 4. The standard model of a summand -/

variable (mu : Measure ℝ) [IsProbabilityMeasure mu]



/-! ## 5. The list -/



end BookProof.ChapterAbelianClassificationList

end



/-!
# The dynamics-based unitary on the infinite lattice `ℓ²(ℤ)`

Source: the manuscript's field-theoretic thread (`QFM.tex`) and the
`ConditionalUnitary` chapter's *"A Less Arbitrary Construction"* section
(`Book/ConditionalUnitary.lean`); proof plan appendix §E
(`Book/ProofPlans.lean`).

`BookProof.ChapterContinuityUnitary` builds the dynamics-based unitary on the
*finite* cyclic lattice `ZMod N`, where every operator is a matrix and the
exponential is a matrix exponential.  Its docstring records the
infinite-dimensional analytic realization as the book's standing open layer.
This module closes that layer in the **bounded** case: the same construction is
carried out on the genuine infinite-dimensional Hilbert space
`ℓ²(ℤ) = lp (fun _ : ℤ => ℂ) 2`, with

* the lattice translations `(S_m f) k = f (k + m)` as *unitaries*
  (`shiftEquiv`), rather than permutation matrices;
* the symmetric-difference momentum `p = -(i/2)(S₁ - S₋₁)` as a **bounded
  self-adjoint operator** (`momentum_isSelfAdjoint`);
* a bounded velocity field `v ∈ ℓ^∞(ℤ)` acting as a bounded self-adjoint
  multiplication operator (`velocityOp_isSelfAdjoint`);
* the Weyl-symmetrized generator `H = ½ (p·v + v·p)`, again bounded and
  self-adjoint (`continuityHamiltonian_isSelfAdjoint`);
* the one-parameter unitary group `U t = exp (i t H)`
  (`continuityUnitary_unitary`, `continuityUnitary_zero`,
  `continuityUnitary_add`), built with the Banach-algebra exponential of
  `ℓ²(ℤ) →L[ℂ] ℓ²(ℤ)`;
* the Born recovery `P(B) = ∑_{z ∈ B} |Ψ_t z|²`, now a **countably** additive
  probability law: `bornRecover_tsum_univ` gives total mass `1` and `bornPMF`
  packages it as a `PMF ℤ`, with the capstone `condProb_of_continuity_infinite`.

The only structural change from the finite chapter is that self-adjointness is
proved through the inner product (`ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric`)
instead of through conjugate transposition of matrices, and that the total mass
is a `tsum` instead of a finite sum.  Unboundedness (the position/momentum
operators of the continuum) remains outside the statement: everything here is a
bounded operator on `ℓ²(ℤ)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped ENNReal InnerProductSpace

namespace BookProof.ChapterContinuityUnitaryInfinite

/-! ## The lattice Hilbert space and the `ℓ^∞` velocity fields -/

/-- The infinite lattice Hilbert space `ℓ²(ℤ)`. -/
abbrev L2Z := lp (fun _ : ℤ => ℂ) 2





/-- Parseval on `ℓ²(ℤ)`: the squared norm is the sum of the squared moduli. -/
theorem norm_sq_eq_tsum (f : L2Z) : ‖f‖ ^ 2 = ∑' k : ℤ, ‖(f : ℤ → ℂ) k‖ ^ 2 := by
  have h := lp.norm_rpow_eq_tsum (p := 2) (by norm_num) f
  rw [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num] at h
  simpa only [Real.rpow_natCast] using h



/-! ## The lattice translations are unitaries -/

theorem memℓp_shift (f : L2Z) (m : ℤ) : Memℓp (fun k : ℤ => (f : ℤ → ℂ) (k + m)) 2 := by
  apply memℓp_gen
  exact ((Equiv.addRight m).summable_iff).2 ((lp.memℓp f).summable (p := 2) (by norm_num))

/-- The lattice translation `(S_m f) k = f (k + m)`, as a linear map. -/
noncomputable def shiftLin (m : ℤ) : L2Z →ₗ[ℂ] L2Z where
  toFun f := ⟨fun k => (f : ℤ → ℂ) (k + m), memℓp_shift f m⟩
  map_add' f g := by ext k; simp
  map_smul' c f := by ext k; simp



theorem shiftLin_norm (m : ℤ) (f : L2Z) : ‖shiftLin m f‖ = ‖f‖ := by
  have key : ‖shiftLin m f‖ ^ 2 = ‖f‖ ^ 2 := by
    rw [norm_sq_eq_tsum, norm_sq_eq_tsum]
    exact (Equiv.addRight m).tsum_eq fun k => ‖(f : ℤ → ℂ) k‖ ^ 2
  have hpow : ‖shiftLin m f‖ ^ ((2 : ℕ) : ℝ) = ‖f‖ ^ ((2 : ℕ) : ℝ) := by
    simpa only [Real.rpow_natCast] using key
  exact Real.rpow_left_injOn (x := ((2 : ℕ) : ℝ)) (by norm_num)
    (norm_nonneg _) (norm_nonneg _) hpow

/-- **The lattice translation is a unitary of `ℓ²(ℤ)`.** -/
noncomputable def shiftEquiv (m : ℤ) : L2Z ≃ₗᵢ[ℂ] L2Z where
  toLinearEquiv :=
    { shiftLin m with
      invFun := shiftLin (-m)
      left_inv := fun f => by ext k; simp
      right_inv := fun f => by ext k; simp }
  norm_map' := shiftLin_norm m

/-- The lattice translation as a bounded operator. -/
noncomputable def shiftOp (m : ℤ) : L2Z →L[ℂ] L2Z :=
  (shiftEquiv m).toLinearIsometry.toContinuousLinearMap

@[simp] theorem shiftOp_apply (m : ℤ) (f : L2Z) (k : ℤ) :
    ((shiftOp m f : L2Z) : ℤ → ℂ) k = (f : ℤ → ℂ) (k + m) := rfl



/-! ## The momentum operator -/

/-- The **symmetric-difference momentum** on the infinite lattice:
`(p f) k = -(i/2) (f (k+1) - f (k-1))`. -/
noncomputable def momentum : L2Z →L[ℂ] L2Z :=
  (-Complex.I / 2) • (shiftOp 1 - shiftOp (-1))







/-! ## The velocity (multiplication) operator -/



















/-! ## The Weyl-symmetrized continuity generator -/







/-! ## The one-parameter unitary group -/













/-! ## Born recovery: a countably additive probability law on the lattice -/























/-! ## The capstone -/

variable {X : Type*}



end BookProof.ChapterContinuityUnitaryInfinite



/-!
# The Faris–Lavine commutator criterion for essential self-adjointness

This module formalizes and **proves** the abstract theorem of

> W. G. Faris and R. B. Lavine, *Commutators and self-adjointness of Hamiltonian
> operators*, Commun. Math. Phys. **35** (1974), 39–48, Theorem 1,

which elsewhere in this project (`BookProof.ChapterNavierStokesFlow`) had to be
carried as a named hypothesis.  The statement of the paper is:

> Let `H` be a Hermitian operator and `N ≥ 0` a positive self-adjoint operator
> with (i) `𝒟(N) ⊆ 𝒟(H)` and (ii) `± i[H, N] ≤ c N` for some `c < ∞`.  Then `H`
> is essentially self-adjoint.

## How the statement is rendered here

* The Hilbert space is a complex inner-product space `F` which is complete.
* `H` and `N` are linear maps `D →ₗ[ℂ] F` on a common domain `D`, which plays the
  role of `𝒟(N)`; hypothesis (i) of the paper is built into this — `H` is defined
  wherever `N` is.  (The conclusion is about the restriction of `H` to `𝒟(N)`,
  which by the last remark of §2 of the paper is the stronger statement: any
  symmetric extension of an essentially self-adjoint operator has the same
  closure.)
* Symmetry is `SymmetricOn`, the quadratic form of `N` is `quadForm`, and
  `commForm H N x = ⟪x, i[H, N] x⟫` is the commutator form; that this is a real
  number is `commForm_eq`.  Hypothesis (ii) is `|commForm H N x| ≤ c * quadForm N x`,
  which is exactly the two-sided bound `± i[H, N] ≤ c N` of the paper.
* Essential self-adjointness is rendered, as everywhere in this project, by the
  vanishing of the deficiency spaces of the adjoint: `EssentiallySelfAdjointOn D H`
  says that no `w ≠ 0` satisfies `⟪H v, w⟫ = ⟪v, ± i w⟫` for all `v ∈ D`.
* Self-adjointness of `N` is used in the paper at exactly one place: it makes
  `N + 1` a bijection of `𝒟(N)` onto the whole space, so that `(N+1)⁻¹ f` is an
  admissible test vector.  That consequence — surjectivity of `N + 1` — is what
  is assumed here (`hNsurj`), so no spectral theory for unbounded operators is
  needed and the criterion applies verbatim to any `N` for which `-1` is in the
  resolvent set.

## Contents

* `deficiencyTrivialAt_of_farisLavine` — the computation of the paper: under the
  Faris–Lavine hypotheses the deficiency space at `d i` vanishes whenever
  `2|d| > c`.  This is the displayed inequality `± 2 d ⟪f, N⁻¹f⟫ ≤ c ⟪f, N⁻¹f⟫`
  of the original proof.
* `exists_weak_graph_limit` — the closure of a symmetric operator with dense
  range of `H - d i` hits every vector: given `y`, there are `u, z` in the closure
  of the graph with `z - d i u = y`.  Proved by hand from the identity
  `‖H x - d i x‖² = ‖H x‖² + d²‖x‖²`, which makes the approximating sequence and
  its image Cauchy.
* `deficiencyTrivialAt_of_dense_range` — the classical basic criterion: for a
  symmetric operator, vanishing of the deficiency spaces at one conjugate pair
  `± d i` (`d ≠ 0`) forces vanishing at *every* non-real point.  This is the step
  that upgrades the paper's "for `|d|` large" to essential self-adjointness.
* `essentiallySelfAdjointOn_of_farisLavine` — **Theorem 1 of Faris–Lavine.**
* `hasZeroDeficiencyOn_of_farisLavine` — the same conclusion in the predicate
  `BookProof.NavierStokesFlow.HasZeroDeficiencyOn` used by the Navier–Stokes
  chapters, for an operator that leaves its domain invariant.
* `not_farisLavine_criterion_of_relative_bound` — a caveat, and the reason the
  hypotheses above are what they are: the *unrestricted* form of the criterion
  (relative bound `‖Hv‖ ≤ a‖Nv‖` plus commutator bound, with no positivity and no
  self-adjointness required of `N`) is **false**; taking `N = H` for the
  limit-circle Jacobi operator of `BookProof.ChapterNavierStokesDeficiency`
  satisfies both inequalities while essential self-adjointness fails.
* `essentiallySelfAdjointOn_of_bounded_symmetric` and
  `multiplication_essentiallySelfAdjoint` — the hypotheses are satisfiable: the
  first in the everywhere-defined case, the second for the (unbounded)
  multiplication operator by an arbitrary real sequence on its maximal domain in
  `ℓ²(ℕ)`.

Nothing here is assumed: the module contains no `axiom`, and every result is
proved from Mathlib.
-/

namespace BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

/-! ## Basic notions -/

/-- `T` is symmetric (Hermitian) on the domain `D`: `⟪T x, y⟫ = ⟪x, T y⟫`. -/
def SymmetricOn (D : Submodule ℂ F) (T : D →ₗ[ℂ] F) : Prop :=
  ∀ x y : D, (inner ℂ (T x) (y : F) : ℂ) = inner ℂ (x : F) (T y)

/-- The deficiency space of the adjoint of `T` at `z` is trivial: the only `w`
with `⟪T v, w⟫ = ⟪v, z w⟫` for all `v` in the domain is `w = 0`.  Equivalently,
the range of `T - z̄` is dense. -/
def DeficiencyTrivialAt (D : Submodule ℂ F) (T : D →ₗ[ℂ] F) (z : ℂ) : Prop :=
  ∀ w : F, (∀ v : D, (inner ℂ (T v) w : ℂ) = z * inner ℂ (v : F) w) → w = 0

/-- **Essential self-adjointness** of a symmetric operator defined on `D`: both
deficiency spaces of the adjoint, at `i` and at `-i`, vanish. -/
def EssentiallySelfAdjointOn (D : Submodule ℂ F) (T : D →ₗ[ℂ] F) : Prop :=
  DeficiencyTrivialAt D T Complex.I ∧ DeficiencyTrivialAt D T (-Complex.I)

/-- The quadratic form `⟪x, N x⟫` of `N` (a real number when `N` is symmetric,
see `quadForm_im`). -/
noncomputable def quadForm (N : D →ₗ[ℂ] F) (x : D) : ℝ := (inner ℂ (x : F) (N x) : ℂ).re



theorem inner_im_swap (a b : F) : (inner ℂ b a : ℂ).im = -(inner ℂ a b : ℂ).im := by
  rw [← inner_conj_symm (𝕜 := ℂ) a b, Complex.conj_im, neg_neg]

/-- The expectation of a symmetric operator is real. -/
theorem inner_apply_self_im (T : D →ₗ[ℂ] F) (hT : SymmetricOn D T) (x : D) :
    (inner ℂ (T x) (x : F) : ℂ).im = 0 := by
  have h := congrArg Complex.im (hT x x)
  rw [inner_im_swap (T x) (x : F)] at h
  linarith

/-- The quadratic form of a symmetric operator is real. -/
theorem quadForm_im (N : D →ₗ[ℂ] F) (hN : SymmetricOn D N) (x : D) :
    (inner ℂ (x : F) (N x) : ℂ).im = 0 := by
  rw [inner_im_swap (N x) (x : F), inner_apply_self_im N hN x, neg_zero]



/-! ## The computation of Faris–Lavine

With `N` replaced by `N + 1` (which changes neither the commutator form, since
`⟪H x, x⟫` is real, nor the validity of the bound, since the form of `N` only
grows), the vector `g = (N+1)⁻¹ w` is admissible, and the deficiency identity at
`d i` reads `Im ⟪H g, (N+1) g⟫ = d ⟪g, (N+1) g⟫`.  The commutator bound turns
this into `2|d| t ≤ c t` with `t = ⟪g, (N+1)g⟫ ≥ ‖g‖²`, so `t = 0` as soon as
`2|d| > c`. -/



/-! ## From dense ranges at one conjugate pair to essential self-adjointness -/









/-! ## Theorem 1 of Faris–Lavine -/





/-! ## Corollary 1.1: the criterion on a core

The paper's Corollary 1.1 weakens the hypotheses to a linear subspace `C` which
is a core: the estimates are only required on `C`, and the conclusion is that the
restriction of `H` to `C` is already essentially self-adjoint.  Here the core
property is stated as it is used — every vector of `𝒟(N)` is approximated by
vectors of `C` *together with* their images under `N` (the graph norm of `N`) —
and the relative bound `‖Hf‖² ≤ a‖Nf‖² + b‖f‖²` transports the approximation from
the graph of `N` to the graph of `H`. -/





end BookProof.FarisLavine



/-!
# Chapter H4 — Hashimoto SIRK: operator φ-function core, compression transfer,
and the conditional convergence headline (roadmap N13, §0 S7)

This file closes the remaining deliverables of the Hashimoto–Nodera
*Shift-invert Rational Krylov (SIRK)* package (source `RiemannProof/Hashimoto.md`),
building on `ChapterH1.lean` (φ-functions, resolvent shift identity) and
`ChapterH2.lean` (Arnoldi/Krylov Hessenberg compression).

## Deliverables (this file)

* **H1.5 — the operator φ-function via the resolvent (Definition 2.4), scalar
  core.** `psi k γ w := phi k (γ − w⁻¹)` is the function whose functional
  calculus at the resolvent `X = (γ − A)⁻¹` *defines* `φ_k(A)`.  The spectral
  consistency of that definition is the scalar identity
  `psi_shift_eq_phi : psi k γ ((γ − z)⁻¹) = phi k z` (for `γ − z ≠ 0`): under the
  shift-invert change of variable `w = (γ − z)⁻¹` one has `γ − w⁻¹ = z`, so
  `ψ_{k,γ}` evaluated at the shift-invert image of `z` returns `φ_k(z)`.

* **H2.2 — the SIRK compression and the rational-function transfer (eq. 10).**
  For an isometric embedding `V : F →L E` (`V∗V = 1`) whose range is invariant
  under a bounded operator `X`, the *compression* `B := V∗ X V : F →L F` is
  exactly the paper's `Hₘ Kₘ⁻¹` (eq. 10 is literally this definition), and it
  satisfies the transfer identities `Xⁿ ∘ V = V ∘ Bⁿ`
  (`compress_pow`), `Xⁿ v = V (Bⁿ (V∗ v))` on the range of `V`
  (`compress_transfer`), and the invertible-factor transfer
  `q(X)⁻¹ ∘ V = V ∘ q(B)⁻¹` (`compress_inv_transfer`).  Together these give the
  load-bearing identity `r(Xₘ) v = Vₘ r(Hₘ Kₘ⁻¹) Vₘ∗ v` used in Theorem 4.1.

* **H2.3 — the SIRK convergence headline (Theorem 4.1), CONDITIONAL.**  The two
  genuinely deep analytic inputs — Crouzeix's inequality (Crouzeix 2007,
  Crouzeix–Palencia) and the deferred `e^{−hm}` deformation of the last step of
  the source Theorem 5 [10] — are **named hypotheses with citation docstrings,
  never axioms**.  Given them, the triangle-inequality core `sirk_error_bound`
  proves `‖φ_k(A)v − Vₘ ψ(HₘKₘ⁻¹) Vₘ∗ v‖ ≤ 2C‖v‖·‖ψ−r‖`, and
  `sirk_error_bound_decay` assembles the eq.-(12) form with the `e^{−hm}` decay.

* **H2.4 — the existing-methods comparison (Remark 4.2), CONDITIONAL.**
  `sia_error_bound` is the analogous SIA bound (15) and `sirk_le_sia` records
  the `e^{−hm}` advantage of SIRK over SIA as an inequality of the two bounds.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).  The only non-proved inputs are the **named** `Crouzeix`/decay
hypotheses of H2.3/H2.4 — by design (the `IsSchurFull`/`EXTERNAL` pattern), never
`axiom`s.
-/

open scoped BigOperators

namespace BookProof.ChapterH4

noncomputable section

/-! ## H1.5 — the operator φ-function via the resolvent (scalar core) -/

/-- **H1.5** (Definition 2.4, scalar function): `ψ_{k,γ}(w) := φ_k(γ − w⁻¹)`.  Its
functional calculus at the resolvent `X = (γ − A)⁻¹` is the Taylor (1951) /
Güttel (2010) definition of the operator φ-function `φ_k(A)`. -/
def psi (k : ℕ) (γ w : ℂ) : ℂ := BookProof.ChapterH1.phi k (γ - w⁻¹)

/-
**H1.5** (spectral consistency of Definition 2.4): under the shift-invert
change of variable `w = (γ − z)⁻¹` one has `γ − w⁻¹ = z`, hence
`ψ_{k,γ}((γ − z)⁻¹) = φ_k(z)`.  This is why applying the functional calculus of
`ψ_{k,γ}` to `X = (γ − A)⁻¹` reproduces `φ_k(A)`.
-/


/-! ## H2.2 — the SIRK compression and rational-function transfer -/

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



/-
**H2.2** (compression intertwines on the range): if `V∗V = 1` and the range
of `V` is `X`-invariant, then `X ∘ V = V ∘ B` for `B = V∗ X V`.
-/


/-
**H2.2** (power transfer): `Xⁿ ∘ V = V ∘ Bⁿ` for all `n`.
-/


/-
**H2.2** (pointwise power transfer on the range): for `v` in the range of `V`
(`V (V∗ v) = v`), `Xⁿ v = V (Bⁿ (V∗ v))`.
-/




/-! ## H2.3 — the SIRK convergence headline (Theorem 4.1), conditional -/

/-
**H2.3** (Theorem 4.1, triangle-inequality core — conditional on Crouzeix).
Abstract statement of the SIRK error bound.  Here:

* `phiA = ψ_{k,γₘ}(Xₘ) = φ_k(A)` is the target operator (`hphi`);
* `psiX, rX : E →L E` are `ψ_{k,γₘ}(Xₘ)` and `r(Xₘ)`;
* `psiB, rB : F →L F` are `ψ_{k,γₘ}(HₘKₘ⁻¹)` and `r(HₘKₘ⁻¹)`;
* `V = Vₘ` is the isometric Krylov embedding (`hViso`, `hVadj`);
* `hrt` is the H2.2 rational-transfer identity `r(Xₘ)v = Vₘ r(HₘKₘ⁻¹) Vₘ∗ v`;
* `hcx1, hcx2` are the two **Crouzeix** operator-norm bounds (eq. 14)
  `‖f(Xₘ)‖ ≤ C‖f‖_{∞,Σ}` — named hypotheses (Crouzeix 2007), **never axioms**.

The conclusion is eq. (13)→(14) of the proof:
`‖φ_k(A)v − Vₘ ψ(HₘKₘ⁻¹) Vₘ∗ v‖ ≤ 2C·D·‖v‖`, with `D = ‖ψ−r‖_{∞,Σ}`.
-/


/-
**H2.3** (Theorem 4.1, eq. 12 form — conditional).  Combining the Crouzeix
core `sirk_error_bound` with the deferred analytic deformation `hdecay`
(`D ≤ e^{−hm}·Dmin`, "the same deformation of the error bound with the last part
of the proof of Theorem 5 [10]", relating `‖ψ_{k,γₘ}−r‖` to
`e^{−hm}·‖f_{k,N}−r‖`) yields the headline exponential-decay bound
`≤ 2C·e^{−hm}·Dmin·‖v‖`.
-/


/-! ## H2.4 — the existing-methods comparison (Remark 4.2), conditional -/

/-
**H2.4** (Remark 4.2, SIA bound (15) — conditional on Crouzeix).  The SIA
approximation `Vₘ ψ_{k,γ}(Hₘ) Vₘ∗ v` obeys the same triangle-inequality bound as
SIRK but *without* the `e^{−hm}` factor: `‖φ_k(A)v − Vₘ ψ(Hₘ) Vₘ∗ v‖ ≤ 2C·Dsia·‖v‖`
with `Dsia = ‖ψ_{k,γ}−p‖_{∞,W((γI−A)⁻¹)}`.  (Same proof shape as
`sirk_error_bound`.)
-/


/-
**H2.4** (the `e^{−hm}` advantage of SIRK over SIA).  For `h, m ≥ 0` the SIRK
eq.-(12) bound is no larger than the corresponding SIA bound (with `Dmin` in the
role of `Dsia`), because `e^{−hm} ≤ 1`.  This is the inequality-of-bounds form of
Remark 4.2's conclusion that "the decay speed of the approximation error of SIRK
will be similar or smaller than that of SIA … due to the factor `e^{−hm}`".
-/


end

end BookProof.ChapterH4



/-!
# The Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`

`PLAN_LEAN_SPECIALIST_QYM_FLOW.md` Part F asks for the *field-space* realization
of the gauge-fixed Yang–Mills Hamiltonian: the fields must act as genuine
multiplication and differentiation operators on a dense core of `L²(ℝ⁹⁹)`,
rather than abstractly on the occupation-number space `ℓ²(ℕ, ℂ)`.

This module builds that core in an arbitrary finite dimension `d`:

* `gaussD x = e^{-‖x‖²/4}` is the `d`-dimensional Gaussian, and for a polynomial
  `p ∈ ℂ[X₀, …, X_{d-1}]` the function `pgFun p x = p(x) · e^{-‖x‖²/4}` is square
  integrable (`memLp_pgFun`); `pgMap` is the resulting linear map
  `ℂ[X] →ₗ[ℂ] L²(ℝᵈ)`, and it is **injective** (`pgMap_injective`);
* `polyGaussCore = range pgMap` — the polynomials times the Gaussian.  This is
  exactly the span of the *product Hermite functions*
  `ψ_α(x) = ∏ᵢ He_{αᵢ}(xᵢ) e^{-xᵢ²/4}` (`polyGaussCore_eq_hermiteSpan`), i.e. the
  `d`-dimensional Hermite core (the span of the product Hermite polynomials is
  the whole polynomial ring, `span_hermiteMv`);
* the core is **dense** (`polyGaussCore_dense`), proved by the multidimensional
  version of the Fourier/moment argument of `BookProof.ChapterHermiteFunctions`;
* the **Gaussian integration-by-parts identity** (`gaussInt_pderiv`) which makes
  the momentum operators symmetric on the core;
* an orthonormal basis `coreBasis` of `L²(ℝᵈ)` adapted to the core, whose span —
  the *finite-mode domain* of the project's Friedrichs/Hashimoto theorems — is
  exactly the core (`span_range_coreBasis`).

The one-dimensional Hermite machinery of `BookProof.ChapterHermiteFunctions`
(`hermiteR`, `gint`, `gint_ibp`) is reused throughout: the `d`-dimensional
statements are reduced to it by Fubini (`integral_prod_coord`).
-/

namespace BookProof.HermiteProductCore

open MeasureTheory Complex MvPolynomial BookProof.HermiteCore
open scoped FourierTransform
open SchwartzMap

noncomputable section

/-- The field space `ℝᵈ`, a `d`-dimensional Euclidean space. -/
abbrev Vd (d : ℕ) := EuclideanSpace ℝ (Fin d)

/-- `L²(ℝᵈ)`. -/
abbrev L2d (d : ℕ) := Lp ℂ 2 (volume : Measure (Vd d))

variable {d : ℕ}

/-! ## Fubini in the coordinates -/



/-- Each coordinate is dominated by the norm. -/
theorem coord_abs_le_norm (x : Vd d) (i : Fin d) : |x i| ≤ ‖x‖ := by
  rw [EuclideanSpace.norm_eq]
  have h : |x i| ^ 2 ≤ ∑ j, |x j| ^ 2 :=
    Finset.single_le_sum (f := fun j => |x j| ^ 2) (by intros; positivity) (Finset.mem_univ i)
  calc |x i| = Real.sqrt (|x i| ^ 2) := (Real.sqrt_sq (abs_nonneg _)).symm
    _ ≤ _ := by
        refine Real.sqrt_le_sqrt ?_
        simpa [Real.norm_eq_abs] using h

/-! ## The Gaussian -/

/-- The `d`-dimensional Gaussian `e^{-‖x‖²/4}`, the square root of the Gaussian
weight `e^{-‖x‖²/2}`. -/
def gaussD (x : Vd d) : ℝ := Real.exp (-‖x‖ ^ 2 / 4)

theorem gaussD_pos (x : Vd d) : 0 < gaussD x := Real.exp_pos _

theorem gaussD_ne_zero (x : Vd d) : gaussD x ≠ 0 := ne_of_gt (gaussD_pos x)

theorem continuous_gaussD : Continuous (gaussD (d := d)) := by
  unfold gaussD; fun_prop

/-- The Gaussian `e^{-c‖x‖²}` is integrable on `ℝᵈ` for every `c > 0`. -/
theorem integrable_gauss {c : ℝ} (hc : 0 < c) :
    Integrable (fun x : Vd d => Real.exp (-c * ‖x‖ ^ 2)) := by
  have h := GaussianFourier.integrable_cexp_neg_mul_sq_norm_add (V := Vd d)
    (b := (c : ℂ)) (by simpa using hc) 0 0
  refine h.norm.congr (Filter.Eventually.of_forall fun v => ?_)
  simp [Complex.norm_exp, ← Complex.ofReal_pow]

/-- A polynomial factor is absorbed by a Gaussian: `tᵏ e^{-t²/8}` is bounded. -/
theorem pow_mul_exp_bound (k : ℕ) {t : ℝ} (ht : 0 ≤ t) :
    t ^ k * Real.exp (-t ^ 2 / 8) ≤ 1 + 8 ^ k * (Nat.factorial k) := by
  have hexp_le_one : Real.exp (-t ^ 2 / 8) ≤ 1 := by
    refine Real.exp_le_one_iff.mpr ?_; nlinarith [sq_nonneg t]
  have hexp_pos : 0 < Real.exp (-t ^ 2 / 8) := Real.exp_pos _
  have hfacpos : (0 : ℝ) < 8 ^ k * (Nat.factorial k) := by positivity
  rcases le_or_gt t 1 with h1 | h1
  · have hk : t ^ k ≤ 1 := pow_le_one₀ ht h1
    have : t ^ k * Real.exp (-t ^ 2 / 8) ≤ 1 := mul_le_one₀ hk (le_of_lt hexp_pos) hexp_le_one
    linarith
  · have hkey : (t ^ 2 / 8) ^ k / (Nat.factorial k) ≤ Real.exp (t ^ 2 / 8) :=
      Real.pow_div_factorial_le_exp _ (by positivity) k
    have hfac : (0 : ℝ) < (Nat.factorial k) := by exact_mod_cast Nat.factorial_pos k
    have h2 : (t ^ 2 / 8) ^ k ≤ (Nat.factorial k) * Real.exp (t ^ 2 / 8) := by
      rw [div_le_iff₀ hfac] at hkey; linarith [hkey]
    have hpow : t ^ k ≤ t ^ (2 * k) := by
      refine pow_le_pow_right₀ (le_of_lt h1) ?_; omega
    have hexp_eq : Real.exp (-t ^ 2 / 8) = (Real.exp (t ^ 2 / 8))⁻¹ := by
      rw [← Real.exp_neg]; ring_nf
    have hE : (0 : ℝ) < Real.exp (t ^ 2 / 8) := Real.exp_pos _
    have h3 : t ^ (2 * k) * Real.exp (-t ^ 2 / 8) ≤ 8 ^ k * (Nat.factorial k) := by
      rw [hexp_eq, mul_inv_le_iff₀ hE, pow_mul]
      have hrw : (t ^ 2) ^ k = 8 ^ k * (t ^ 2 / 8) ^ k := by
        rw [← mul_pow]; ring_nf
      rw [hrw]
      have hmul := mul_le_mul_of_nonneg_left h2 (le_of_lt (pow_pos (by norm_num : (0:ℝ) < 8) k))
      calc (8 : ℝ) ^ k * (t ^ 2 / 8) ^ k ≤ 8 ^ k * ((Nat.factorial k) * Real.exp (t ^ 2 / 8)) :=
            hmul
        _ = 8 ^ k * (Nat.factorial k) * Real.exp (t ^ 2 / 8) := by ring
    nlinarith [mul_le_mul_of_nonneg_right hpow (le_of_lt hexp_pos)]

/-- `‖x‖ᵏ e^{-‖x‖²/4}` is square integrable on `ℝᵈ`. -/
theorem memLp_pow_mul_gaussD (k : ℕ) :
    MemLp (fun x : Vd d => ‖x‖ ^ k * gaussD x) 2 (volume : Measure (Vd d)) := by
  set C : ℝ := 1 + 8 ^ k * (Nat.factorial k) with hC
  have hCpos : 0 ≤ C := by positivity
  have hgmem : MemLp (fun x : Vd d => C * Real.exp (-‖x‖ ^ 2 / 8)) 2 (volume : Measure (Vd d)) := by
    refine (memLp_two_iff_integrable_sq (by fun_prop)).mpr ?_
    have hint : Integrable (fun x : Vd d => Real.exp (-(1/4 : ℝ) * ‖x‖ ^ 2)) :=
      integrable_gauss (by norm_num)
    refine (hint.const_mul (C ^ 2)).congr (Filter.Eventually.of_forall fun x => ?_)
    simp only
    rw [mul_pow, pow_two (Real.exp _), ← Real.exp_add]
    ring_nf
  refine hgmem.mono (by unfold gaussD; fun_prop) (Filter.Eventually.of_forall fun x => ?_)
  have hb := pow_mul_exp_bound (t := ‖x‖) k (norm_nonneg x)
  have hgauss : gaussD x = Real.exp (-‖x‖ ^ 2 / 8) * Real.exp (-‖x‖ ^ 2 / 8) := by
    rw [← Real.exp_add]; unfold gaussD; ring_nf
  have hpos : (0 : ℝ) < Real.exp (-‖x‖ ^ 2 / 8) := Real.exp_pos _
  have hnn : 0 ≤ ‖x‖ ^ k * gaussD x := by
    have := gaussD_pos x; positivity
  rw [Real.norm_eq_abs, Real.norm_eq_abs, abs_of_nonneg hnn,
    abs_of_nonneg (by positivity : (0:ℝ) ≤ C * Real.exp (-‖x‖ ^ 2 / 8))]
  calc ‖x‖ ^ k * gaussD x
      = (‖x‖ ^ k * Real.exp (-‖x‖ ^ 2 / 8)) * Real.exp (-‖x‖ ^ 2 / 8) := by
        rw [hgauss]; ring
    _ ≤ C * Real.exp (-‖x‖ ^ 2 / 8) := by
        exact mul_le_mul_of_nonneg_right hb (le_of_lt hpos)

/-! ## Polynomials times the Gaussian -/

/-- `pgFun p x = p(x) · e^{-‖x‖²/4}`: a polynomial in the coordinates of `ℝᵈ`
times the Gaussian. -/
def pgFun (p : MvPolynomial (Fin d) ℂ) (x : Vd d) : ℂ :=
  MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p * (gaussD x : ℂ)

theorem continuous_polyEval (p : MvPolynomial (Fin d) ℂ) :
    Continuous (fun x : Vd d => MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p) := by
  induction p using MvPolynomial.induction_on with
  | C a => simpa using continuous_const
  | add p q hp hq => simpa using hp.add hq
  | mul_X p i hp =>
      simp only [map_mul, MvPolynomial.eval_X]
      exact hp.mul (by fun_prop)

theorem continuous_pgFun (p : MvPolynomial (Fin d) ℂ) : Continuous (pgFun p) := by
  unfold pgFun
  exact (continuous_polyEval p).mul (Complex.continuous_ofReal.comp continuous_gaussD)



theorem pgFun_add (p q : MvPolynomial (Fin d) ℂ) : pgFun (p + q) = pgFun p + pgFun q := by
  funext x; simp [pgFun, add_mul]

theorem pgFun_smul (c : ℂ) (p : MvPolynomial (Fin d) ℂ) : pgFun (c • p) = c • pgFun p := by
  funext x; simp [pgFun, smul_eq_mul, mul_assoc]

/-- A monomial times the Gaussian is square integrable. -/
theorem memLp_pgFun_monomial (a : Fin d →₀ ℕ) (c : ℂ) :
    MemLp (pgFun (monomial a c)) 2 (volume : Measure (Vd d)) := by
  set k : ℕ := ∑ b ∈ a.support, a b with hk
  have hmem : MemLp (fun x : Vd d => ‖c‖ * (‖x‖ ^ k * gaussD x)) 2 (volume : Measure (Vd d)) :=
    (memLp_pow_mul_gaussD (d := d) k).const_mul ‖c‖
  refine hmem.mono ((continuous_pgFun (monomial a c)).aestronglyMeasurable)
    (Filter.Eventually.of_forall fun x => ?_)
  have hgauss : (0 : ℝ) < gaussD x := gaussD_pos x
  have hprod : ∏ b ∈ a.support, ‖((x b : ℝ) : ℂ) ^ a b‖ ≤ ‖x‖ ^ k := by
    rw [hk, ← Finset.prod_pow_eq_pow_sum]
    refine Finset.prod_le_prod (fun i _ => by positivity) (fun i _ => ?_)
    rw [norm_pow]
    have h1 : ‖((x i : ℝ) : ℂ)‖ ≤ ‖x‖ := by simpa using coord_abs_le_norm x i
    exact pow_le_pow_left₀ (norm_nonneg _) h1 _
  have hval : ‖pgFun (monomial a c) x‖
      = ‖c‖ * (∏ b ∈ a.support, ‖((x b : ℝ) : ℂ) ^ a b‖) * gaussD x := by
    rw [pgFun, MvPolynomial.eval_monomial, norm_mul, norm_mul, Finsupp.prod, norm_prod]
    rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos hgauss]
  have hrhs : ‖‖c‖ * (‖x‖ ^ k * gaussD x)‖ = ‖c‖ * (‖x‖ ^ k * gaussD x) :=
    Real.norm_of_nonneg (by positivity)
  rw [hval, hrhs]
  have hstep := mul_le_mul_of_nonneg_right hprod (le_of_lt hgauss)
  calc ‖c‖ * (∏ b ∈ a.support, ‖((x b : ℝ) : ℂ) ^ a b‖) * gaussD x
      = ‖c‖ * ((∏ b ∈ a.support, ‖((x b : ℝ) : ℂ) ^ a b‖) * gaussD x) := by ring
    _ ≤ ‖c‖ * (‖x‖ ^ k * gaussD x) := mul_le_mul_of_nonneg_left hstep (norm_nonneg c)

/-- **A polynomial times the Gaussian is square integrable.** -/
theorem memLp_pgFun (p : MvPolynomial (Fin d) ℂ) :
    MemLp (pgFun p) 2 (volume : Measure (Vd d)) := by
  have hsum : p = ∑ v ∈ p.support, (monomial v) (MvPolynomial.coeff v p) :=
    (MvPolynomial.support_sum_monomial_coeff p).symm
  have hfun : pgFun p = fun x => ∑ v ∈ p.support, pgFun ((monomial v) (coeff v p)) x := by
    funext x
    rw [pgFun]
    nth_rewrite 1 [hsum]
    simp only [map_sum, Finset.sum_mul, pgFun]
  rw [hfun]
  exact memLp_finset_sum _ fun v _ => memLp_pgFun_monomial v _

/-! ## The core as the range of a linear map -/

/-- `p ↦ [p · e^{-‖x‖²/4}]` as an element of `L²(ℝᵈ)`. -/
def pgLp (p : MvPolynomial (Fin d) ℂ) : L2d d := (memLp_pgFun p).toLp _

theorem pgLp_coeFn (p : MvPolynomial (Fin d) ℂ) :
    (pgLp p : Vd d → ℂ) =ᵐ[volume] pgFun p := (memLp_pgFun p).coeFn_toLp

/-- **The Gauss–polynomial map** `ℂ[X₀, …, X_{d-1}] →ₗ[ℂ] L²(ℝᵈ)`. -/
def pgMap : MvPolynomial (Fin d) ℂ →ₗ[ℂ] L2d d where
  toFun := pgLp
  map_add' p q := by
    have h : pgFun (p + q) = pgFun p + pgFun q := pgFun_add p q
    simp only [pgLp]
    rw [← MemLp.toLp_add (memLp_pgFun p) (memLp_pgFun q)]
    congr 1
  map_smul' c p := by
    have h : pgFun (c • p) = c • pgFun p := pgFun_smul c p
    simp only [pgLp, RingHom.id_apply]
    rw [← MemLp.toLp_const_smul c (memLp_pgFun p)]
    congr 1

@[simp] theorem pgMap_apply (p : MvPolynomial (Fin d) ℂ) : pgMap p = pgLp p := rfl

/-- A multivariate polynomial with complex coefficients vanishing at every *real*
point of `ℝᵈ` is the zero polynomial. -/
theorem mvpoly_eq_zero_of_eval_real : ∀ {n : ℕ} {p : MvPolynomial (Fin n) ℂ},
    (∀ x : Fin n → ℝ, eval (fun i => ((x i : ℝ) : ℂ)) p = 0) → p = 0 := by
  intro n
  induction n with
  | zero =>
      intro p h
      refine MvPolynomial.funext fun x => ?_
      have hx : x = fun i => (((fun _ : Fin 0 => (0 : ℝ)) i : ℝ) : ℂ) := by
        funext i; exact i.elim0
      rw [hx, h, map_zero]
  | succ n ih =>
      intro p h
      set P := (MvPolynomial.finSuccEquiv ℂ n) p with hP
      have hcoeff : ∀ k, P.coeff k = 0 := by
        intro k
        refine ih (p := P.coeff k) fun x => ?_
        have hQ : Polynomial.map (eval (fun i => ((x i : ℝ) : ℂ))) P = 0 := by
          refine Polynomial.eq_zero_of_infinite_isRoot _ ?_
          refine Set.Infinite.mono (s := Set.range ((↑) : ℝ → ℂ)) ?_ ?_
          · rintro _ ⟨y, rfl⟩
            have hy := h (Fin.cons y x)
            have hcons : (fun i : Fin (n + 1) => (((Fin.cons y x : Fin (n + 1) → ℝ) i : ℝ) : ℂ))
                = Fin.cons ((y : ℝ) : ℂ) (fun i => ((x i : ℝ) : ℂ)) := by
              funext i
              refine Fin.cases ?_ ?_ i <;> simp
            rw [hcons, MvPolynomial.eval_eq_eval_mv_eval'] at hy
            simpa [Polynomial.IsRoot, hP] using hy
          · exact Set.infinite_range_of_injective Complex.ofReal_injective
        have hc := congrArg (fun q : Polynomial ℂ => q.coeff k) hQ
        simpa using hc
      have hP0 : P = 0 := Polynomial.ext fun k => by simpa using hcoeff k
      have hfin := congrArg (MvPolynomial.finSuccEquiv ℂ n).symm hP0
      simpa [hP] using hfin

/-- **The Gauss–polynomial map is injective**: distinct polynomials give distinct
elements of `L²(ℝᵈ)`.  Equivalently the monomials times the Gaussian are linearly
independent. -/
theorem pgMap_injective : Function.Injective (pgMap (d := d)) := by
  rw [injective_iff_map_eq_zero]
  intro p hp
  have hae : pgFun p =ᵐ[volume] 0 := by
    have h0 : (pgLp p : Vd d → ℂ) =ᵐ[volume] 0 := by
      have hp0 : pgLp p = 0 := by simpa [pgMap_apply] using hp
      rw [hp0]
      exact Lp.coeFn_zero (E := ℂ) (p := 2) (μ := (volume : Measure (Vd d)))
    exact (pgLp_coeFn p).symm.trans h0
  have hzero : pgFun p = 0 :=
    ((continuous_pgFun p).ae_eq_iff_eq volume continuous_const).mp hae
  refine mvpoly_eq_zero_of_eval_real fun x => ?_
  have hx := congrFun hzero ((WithLp.toLp 2 x : Vd d))
  simp only [pgFun, Pi.zero_apply, mul_eq_zero] at hx
  rcases hx with hx | hx
  · simpa using hx
  · exact absurd (by exact_mod_cast hx) (gaussD_ne_zero _)

/-- **The Gauss–polynomial (product Hermite) core** of `L²(ℝᵈ)`: all polynomials
times the Gaussian `e^{-‖x‖²/4}`. -/
def polyGaussCore : Submodule ℂ (L2d d) := LinearMap.range (pgMap (d := d))



/-! ## Density of the core: the multidimensional Fourier/moment argument -/



















/-! ## The core is dense -/

theorem inner_pgLp (p : MvPolynomial (Fin d) ℂ) (u : L2d d) :
    (inner ℂ (pgLp p) u : ℂ)
      = ∫ x : Vd d, (starRingEnd ℂ) (pgFun p x) * (u : Vd d → ℂ) x := by
  rw [L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [pgLp_coeFn p] with x hx
  rw [hx, RCLike.inner_apply, mul_comm]





/-! ## Gaussian moments and integration by parts

The momentum operators are symmetric on the core because of the Gaussian
integration-by-parts identity `∫ (∂ⱼ r) e^{-‖x‖²/2} = ∫ xⱼ r e^{-‖x‖²/2}`, which is
proved here by reducing to the one-dimensional identity `gint_ibp` of
`BookProof.ChapterHermiteFunctions` by Fubini. -/

/-- The Gaussian weight `e^{-‖x‖²/2} = (e^{-‖x‖²/4})²`. -/
def gaussWD (x : Vd d) : ℝ := Real.exp (-‖x‖ ^ 2 / 2)

theorem gaussWD_eq_sq (x : Vd d) : gaussWD x = gaussD x * gaussD x := by
  rw [gaussWD, gaussD, ← Real.exp_add]
  ring_nf





/-- `r ↦ ∫ r(x) e^{-‖x‖²/2} dx`, the Gaussian-weighted integral of a polynomial:
the `d`-dimensional analogue of `BookProof.HermiteCore.gint`. -/
def gaussInt (r : MvPolynomial (Fin d) ℂ) : ℂ :=
  ∫ x : Vd d, MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) r * (gaussWD x : ℂ)



















/-! ## An orthonormal basis of `L²(ℝᵈ)` whose finite-mode domain is the core

The abstract Friedrichs/Hashimoto theorems of the project are stated for the
*finite-mode domain* `span (range b)` of a `HilbertBasis ℕ`.  Enumerating the
monomials and orthonormalizing the resulting family of Gauss–polynomials by the
Gram–Schmidt process produces such a basis whose finite-mode domain is exactly
the core `polyGaussCore`. -/














/-! ## The core is the span of the product Hermite functions

The core was defined as *all* polynomials times the Gaussian.  The name "product
Hermite core" is justified here: the products `∏ᵢ He_{αᵢ}(xᵢ)` of probabilists'
Hermite polynomials span the same space, because the three-term recurrence
`X · He_n = He_{n+1} + n · He_{n-1}` makes their span stable under multiplication
by each coordinate. -/





/-- The probabilists' Hermite polynomial with complex coefficients. -/
def hermiteCx (n : ℕ) : Polynomial ℂ := (Polynomial.hermite n).map (Int.castRingHom ℂ)





/-- The Hermite factor `He_n(x_i)` in the `i`-th coordinate. -/
def hermiteFactor (i : Fin d) (n : ℕ) : MvPolynomial (Fin d) ℂ :=
  Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ) (hermiteCx n)





/-- The **product Hermite polynomial** `∏ᵢ He_{αᵢ}(xᵢ)`. -/
def hermiteMv (a : Fin d →₀ ℕ) : MvPolynomial (Fin d) ℂ := ∏ i, hermiteFactor i (a i)













end

end BookProof.HermiteProductCore



/-!
# `L∞(μ)` is *maximal* abelian on `L²(μ)` — the diffuse half of the classification

`ChapterLinftyMultiplication` builds the diffuse model of the abelian
classification: for essentially bounded `φ : α → ℂ` the multiplication operators
`multOp φ : L²(μ) →L[ℂ] L²(μ)` form a unital, abelian, star-closed and faithful
algebra.  `ChapterAbelianAtomicCondensation` proves the *atomic* condensation:
a purely atomic maximal abelian algebra **is** the diagonal algebra `ℓ∞`.

This module proves the matching statement for the diffuse model, which is the
structural fact the classification actually rests on:

  **the multiplication algebra is its own commutant.**

Concretely (`commutant_eq_multOp`), on a finite measure space every bounded
operator `T` on `L²(μ)` that commutes with *every* multiplication operator is
itself a multiplication operator `T = multOp ψ`, and its symbol is
`ψ = T(1)` with `‖ψ‖_∞ ≤ ‖T‖` (`symbol_ae_norm_le`,
`memLp_top_symbol`).  Hence the algebra is **maximal abelian**
(`multOp_algebra_maximal_abelian`): no bounded operator can be adjoined to it
without breaking commutativity.  Specialized to Lebesgue measure on `[0,1]`
(`unitInterval_multOp_maximal_abelian`) this is the diffuse companion of the
atomic condensation — the two ends of the classification list.

The proof is the classical one:

* `symbol T := T(1)` makes sense because `1 ∈ L²(μ)` for a finite measure;
* `symbol_mul` — commutation gives `T(φ) = φ · ψ` for every bounded `φ`;
* `symbol_ae_norm_le` — testing on the indicator of `{‖ψ‖ ≥ ‖T‖ + ε}` and
  comparing the two `L²` norms forces that set to be null, so `ψ ∈ L∞(μ)`;
* `commutant_eq_multOp` — `T` and `multOp ψ` are continuous and agree on the
  indicator functions, hence everywhere, by `Lp.induction`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

open MeasureTheory ENNReal Complex

namespace BookProof.ChapterLinftyMaximalAbelian

open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]

/-- The constant function `1`, as an element of `L²(μ)` (available because `μ`
is finite).  It is the cyclic vector of the multiplication algebra. -/
def oneLp (μ : Measure α) [IsFiniteMeasure μ] : Lp ℂ 2 μ :=
  MemLp.toLp (fun _ : α => (1 : ℂ)) (memLp_const 1)



/-- The **symbol** of an operator: a strongly measurable representative of
`T(1)`.  For a `T` commuting with all multiplications this is the essentially
bounded function that `T` multiplies by. -/
def symbol (T : Lp ℂ 2 μ →L[ℂ] Lp ℂ 2 μ) : α → ℂ :=
  (Lp.aestronglyMeasurable (T (oneLp μ))).mk _





















end BookProof.ChapterLinftyMaximalAbelian

end



/-!
# Symmetry and density are not enough: an operator whose adjoint has deficiency

Companion to `BookProof.ChapterNavierStokesEsa`.  That module proves two
*positive* criteria for essential self-adjointness on a dense domain: a complete
unitary flow suffices (`hasZeroDeficiencyOn_of_completeUnitaryFlow`), and so does
boundedness (`hasZeroDeficiencyOn_of_bounded_symmetric`).

This module supplies the matching *negative* fact, which is what makes those
criteria necessary rather than decorative: there is a symmetric operator, defined
on a dense invariant domain of a Hilbert space, whose adjoint **does** have a
deficiency vector — so it is not essentially self-adjoint.  Hence no argument
resting only on symmetry (the "polynomial of low degree in the fields" input of
`book.tex` ~4199) can establish essential self-adjointness; an analytic criterion
— flow completeness, boundedness, Faris–Lavine — is genuinely required.

The example is the classical *limit-circle Jacobi matrix*: on `ℓ²(ℕ)`, with the
finitely supported states as domain,

`(H f)(0) = a₀ f(1)`,  `(H f)(n+1) = aₙ f(n) + a₍ₙ₊₁₎ f(n+2)`,

a real symmetric tridiagonal operator with rapidly growing weights
`a₀ = 2`, `a₍ₙ₊₁₎ = 4aₙ + 2`.  The weights are chosen so that the geometric
sequence `w(n) = (i/2)ⁿ` — which is square-summable — solves `H w = i w`
coefficientwise, and therefore is a deficiency vector of the adjoint.

## Scope

This is a statement about a concrete example, not about Navier–Stokes: it
delimits what the truncation results of `BookProof.ChapterNavierStokesFlow` can
and cannot be extended by.  Nothing here claims anything about the continuum
Navier–Stokes generator.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace LpNat



/-- Square-summability of the moduli is membership in `ℓ²`. -/
theorem memLpTwo_of_summable_normSq {ι : Type*} {g : ι → ℂ}
    (h : Summable fun k => ‖g k‖ ^ 2) : Memℓp g 2 := by
  apply memℓp_gen
  simpa [show (2 : ℝ≥0∞).toReal = ((2 : ℕ) : ℝ) from by norm_num, Real.rpow_natCast] using h







/-! ## Inner products against a finitely supported state -/


end LpNat

namespace JacobiDeficiency

open LpNat

/-! ## The Jacobi weights and the tridiagonal operator -/






















/-! ## Symmetry of the operator -/



/-! ## The deficiency vector -/



















end JacobiDeficiency

/-! ## The positive counterpart: an unbounded operator that *is* essentially
self-adjoint

The Jacobi example above is unbounded and fails to be essentially self-adjoint.
Unboundedness alone is therefore not the obstruction either: a diagonal operator
with arbitrary real (possibly unbounded) entries is essentially self-adjoint on
the very same domain, by the eigenvector criterion
`hasZeroDeficiencyOn_of_total_eigenvectors`.  What separates the two examples is
whether the domain carries enough eigenvectors — equivalently, in the Jacobi
case, whether the classical difference equation is in the limit-point or the
limit-circle class. -/

namespace DiagonalEsa

open LpNat









/-- The canonical basis state `e_n`, as an element of the finite-mode domain. -/
noncomputable def basis (n : ℕ) : lpFiniteModes ℕ :=
  ⟨lp.single 2 n 1, lpSingle_mem_lpFiniteModes n 1⟩











end DiagonalEsa

end BookProof.NavierStokesFlow



/-!
# The one-particle comparison operator, and how the Faris–Lavine bounds lift

Companion to `BookProof.ChapterNavierStokesSecondQuant`, which lifts *essential
self-adjointness* from the sectors of a Fock space to the finite-particle
domain.  This module supplies the other two ingredients of the Faris–Lavine
route to essential self-adjointness of the Navier–Stokes Hamiltonian:

**1. The one-particle comparison operator.**  In the fiber space the advection
term is a *linear* vector field `V(u)`, so the natural comparison operator is
`n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I`.  `ComparisonData` packages the (symmetric) momenta
`πᵢ` and drifts `Vᵢ` on a dense domain of an arbitrary complex inner product
space, and `ComparisonData.comparison` is the operator.  Proved here:
`comparison_isSymmetricDom` (symmetry), `comparison_inner_eq` (the quadratic
form is `∑‖πᵢv‖² + ∑‖Vᵢv‖² + ‖v‖²` — no cross terms, because the squares are
squares of symmetric operators), `comparison_ge_norm_sq` (`n ≥ I`, the
positivity Faris–Lavine asks of the comparison operator) and two criteria for
essential self-adjointness: `comparison_hasZeroDeficiencyOn_of_eigenvectors`
from a total family of eigenvectors, and `diagComparison_hasZeroDeficiencyOn`,
an unconditional instance in the representation in which the `πᵢ` and `Vᵢ` are
simultaneously diagonal (the fiber momentum representation), where the operator
is also genuinely unbounded (`diagComparison_not_bounded`).

**2. How the two Faris–Lavine bounds behave when summed over particles.**  On an
`m`-particle sector the second-quantized operators are `Ĥ = ∑ₖ hₖ` and
`N̂ = ∑ₖ nₖ + I`.

* `norm_sum_le_of_pairwise` — the *operator* bound lifts with the **same**
  constant provided the domination holds *pairwise*,
  `|Re⟪hₖv, hₗv⟫| ≤ c² Re⟪nₖv, nₗv⟫` for all pairs `k, l`.
* `not_forall_norm_sum_le_of_pointwise` — and pairwise is genuinely needed: the
  naive argument "triangle inequality plus the one-particle bound" is **not**
  valid.  There are two pairs `(hₖ, nₖ)` with `‖hₖ x‖ ≤ ‖nₖ x‖` for every `x`
  and yet `‖(h₀ + h₁)x‖ > ‖(n₀ + n₁)x‖`; the step
  `∑ₖ ‖nₖ Ψ‖ ≤ ‖N̂ Ψ‖` in the informal argument is false as stated.
* `abs_re_inner_commutator_sum_le` — the *form commutator* bound, by contrast,
  lifts exactly as the informal argument says, because quadratic forms are
  additive: with `[hₖ, nₗ] = 0` for `k ≠ l` (different particles) one has
  `[Ĥ, N̂] = ∑ₖ [hₖ, nₖ]`(`commDom_sum`, `commDom_add_id`) and therefore
  `|Re⟪Ψ, [Ĥ, N̂]Ψ⟫| ≤ c₂ Re⟪Ψ, N̂Ψ⟫`.

## Scope

Nothing here claims essential self-adjointness of the continuum Navier–Stokes
generator.  The Faris–Lavine criterion itself is not proved anywhere in this
project; it enters as a named hypothesis (`ns_esa_of_farisLavine_dense`).  What
is established here is exactly which bounds survive second quantization, and in
what form.
-/

namespace BookProof.NavierStokesFlow

namespace FarisLavineLift

open FullEsa

/-! ## Elementary inner-product facts -/

section Elementary

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]





end Elementary

/-! ## The one-particle comparison operator `n = π² + V² + I` -/

section Comparison

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The data of a one-particle comparison operator on a fiber space: a dense
domain, the momenta `πᵢ = -i ∂/∂uᵢ` and the drifts `Vᵢ(u)`, all symmetric and
preserving the domain.  In the Navier–Stokes fiber space `Vᵢ(u) = u_{i,j}u_j −
ν u_{i,jj}` is a *linear* function of the (independent) fiber coordinates, so
`Vᵢ²` is a non-negative quadratic potential. -/
structure ComparisonData (F : Type*) [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    (d : ℕ) where
  /-- The dense domain (a core: in the Navier–Stokes fiber space, `C_c^∞`). -/
  D : Submodule ℂ F
  /-- The domain is dense. -/
  dense : Dense (D : Set F)
  /-- The momenta. -/
  mom : Fin d → (D →ₗ[ℂ] D)
  /-- The drift (advection) fields. -/
  drift : Fin d → (D →ₗ[ℂ] D)
  /-- Each momentum is symmetric. -/
  mom_symm : ∀ i, IsSymmetricDom (mom i)
  /-- Each drift is symmetric. -/
  drift_symm : ∀ i, IsSymmetricDom (drift i)

namespace ComparisonData

variable {d : ℕ} (c : ComparisonData F d)

/-- The comparison operator `n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I`. -/
noncomputable def comparison : c.D →ₗ[ℂ] c.D :=
  (∑ i, (c.mom i).comp (c.mom i)) + (∑ i, (c.drift i).comp (c.drift i)) + LinearMap.id











end ComparisonData

end Comparison

/-! ### An unconditional instance: the comparison operator in the momentum
representation -/

section DiagonalComparison

open LpNat DiagonalEsa











end DiagonalComparison

/-! ## Lifting the two Faris–Lavine bounds over the particles of a sector -/

section Lifting

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {κ : Type*}







/-! ### The commutator -/













end Lifting

/-! ## Sharpness: the naive lifting of the operator bound is invalid -/

section Sharpness

open EuclideanSpace

/-- The two-dimensional fiber used for the counterexample. -/
abbrev E2 := EuclideanSpace ℂ (Fin 2)





















end Sharpness

end FarisLavineLift

end BookProof.NavierStokesFlow



/-!
# The canonical pairs behind the many-mode Navier–Stokes Hamiltonian

`BookProof.ChapterNavierStokesFockManyMode` proves the two Faris–Lavine
inequalities for a concrete operator `fockH` on the Fock space `ℓ²(ℕᵈ)` of a
`d`-mode field, and for the diagonal comparison operator `diagMax (fockSym κ)`.
This module verifies that these two operators really *are* the Navier–Stokes
objects they are advertised to be:

* `Ĥ = ∑ᵢ ½(πᵢ Vᵢ + Vᵢ πᵢ)`, the symmetrised transport operator of the field, and
* `N̂ = ∑ᵢ (πᵢ² + Vᵢ²) + I`, the comparison operator built from the squares of the
  individual non-commuting pieces,

for the canonical pairs `πᵢ = -i ∂/∂uᵢ`, `uᵢ` of the modes and the *linear*
advection fields `Vᵢ(u) = κᵢ uᵢ`.  Everything is checked on the
finite-configuration core `lpFiniteModes (Occ d)`.

## Contents

* `ann i`, `cre i` — the annihilation and creation operators of the mode `i`,
  with `[aᵢ, aᵢ†] = I` (`comm_ann_cre`);
* `mom κ i`, `pos κ i`, `drift κ i` — the momentum `πᵢ`, the fiber coordinate
  `uᵢ` and the advection field `Vᵢ = κᵢ uᵢ`;
* `comm_mom_pos` — **`[πᵢ, uᵢ] = -i`**;
* `fock_comparison_eq` — **`∑ᵢ(πᵢ² + Vᵢ²) + I = N̂`**;
* `fock_hamiltonian_eq` — **`∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ) = Ĥ`**;
* `fock_canonical_essentiallySelfAdjointOn_core` — hence the canonically written
  many-mode Navier–Stokes Hamiltonian is essentially self-adjoint on the
  finite-configuration core.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace FockCanonical

open LpNat FarisLavine IkebeKato ShiftHamiltonian FockManyMode HermiteCanonical

variable {d : ℕ} {κ : Fin d → ℝ}

/-! ## Raising and lowering a single occupation number -/

/-- Add one quantum in the mode `i`. -/
def up (i : Fin d) (α : Occ d) : Occ d := Function.update α i (α i + 1)

/-- Remove one quantum from the mode `i` (nothing happens if the mode is
empty). -/
def dn (i : Fin d) (α : Occ d) : Occ d := Function.update α i (α i - 1)

@[simp] theorem up_self (i : Fin d) (α : Occ d) : up i α i = α i + 1 := by simp [up]

@[simp] theorem dn_self (i : Fin d) (α : Occ d) : dn i α i = α i - 1 := by simp [dn]

theorem up_injective (i : Fin d) : Function.Injective (up i : Occ d → Occ d) := by
  intro α β h
  funext j
  by_cases hj : j = i
  · subst hj
    have hji := congrFun h j
    simp only [up, Function.update_self] at hji
    omega
  · have hji := congrFun h j
    simpa [up, hj] using hji

@[simp] theorem dn_up (i : Fin d) (α : Occ d) : dn i (up i α) = α := by
  funext j
  by_cases hj : j = i
  · subst hj; simp [up, dn]
  · simp [up, dn, hj]

theorem up_dn (i : Fin d) {α : Occ d} (h : 1 ≤ α i) : up i (dn i α) = α := by
  funext j
  by_cases hj : j = i
  · subst hj
    simp only [up, dn, Function.update_self]
    omega
  · simp [up, dn, hj]







/-! ## Annihilation and creation in a single mode -/

/-- `aᵢ x` has coordinates `√(αᵢ+1) x_{α+eᵢ}`. -/
noncomputable def annFun (i : Fin d) (X : Occ d → ℂ) : Occ d → ℂ :=
  fun α => (Real.sqrt ((α i : ℝ) + 1) : ℂ) * X (up i α)

/-- `aᵢ† x` has coordinates `√(αᵢ) x_{α−eᵢ}`. -/
noncomputable def creFun (i : Fin d) (X : Occ d → ℂ) : Occ d → ℂ :=
  fun α => (Real.sqrt (α i : ℝ) : ℂ) * X (dn i α)

theorem support_annFun (i : Fin d) {X : Occ d → ℂ} (h : (Function.support X).Finite) :
    (Function.support (annFun i X)).Finite := by
  refine Set.Finite.subset (h.preimage (f := up i)
    (Set.injOn_of_injective (up_injective i))) ?_
  intro α hα
  simp only [Function.mem_support, annFun] at hα
  simp only [Set.mem_preimage, Function.mem_support]
  intro h0
  exact hα (by rw [h0, mul_zero])

theorem support_creFun (i : Fin d) {X : Occ d → ℂ} (h : (Function.support X).Finite) :
    (Function.support (creFun i X)).Finite := by
  refine Set.Finite.subset (h.image (up i)) ?_
  intro α hα
  simp only [Function.mem_support, creFun] at hα
  have hpos : 1 ≤ α i := by
    by_contra hc
    have h0 : α i = 0 := by omega
    apply hα
    rw [h0]
    simp
  refine ⟨dn i α, ?_, up_dn i hpos⟩
  simp only [Function.mem_support]
  intro h0
  exact hα (by rw [h0, mul_zero])

/-- **The annihilation operator of the mode `i`.** -/
noncomputable def ann (i : Fin d) : lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) where
  toFun x := ⟨⟨annFun i ((x : L2I (Occ d)) : Occ d → ℂ),
      memLpTwo_of_finite_support (support_annFun i x.2)⟩, support_annFun i x.2⟩
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun α => ?_))
    simp only [annFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun α => ?_))
    simp only [annFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring

/-- **The creation operator of the mode `i`.** -/
noncomputable def cre (i : Fin d) : lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) where
  toFun x := ⟨⟨creFun i ((x : L2I (Occ d)) : Occ d → ℂ),
      memLpTwo_of_finite_support (support_creFun i x.2)⟩, support_creFun i x.2⟩
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun α => ?_))
    simp only [creFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun α => ?_))
    simp only [creFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring





/-! ### The quadratic expressions -/













/-! ## The canonical pair and the advection field of a mode -/

/-- The momentum of the mode `i`: `πᵢ = i√(κᵢ/2)(aᵢ† − aᵢ)`. -/
noncomputable def mom (κ : Fin d → ℝ) (i : Fin d) :
    lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) :=
  (Complex.I * (Real.sqrt (κ i / 2) : ℂ)) • (cre i - ann i)

/-- The fiber coordinate of the mode `i`: `uᵢ = (2κᵢ)^(-1/2)(aᵢ + aᵢ†)`. -/
noncomputable def pos (κ : Fin d → ℝ) (i : Fin d) :
    lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) :=
  ((1 / Real.sqrt (2 * κ i) : ℝ) : ℂ) • (cre i + ann i)

/-- The linear advection field of the mode `i`: `Vᵢ(u) = κᵢ uᵢ = √(κᵢ/2)(aᵢ + aᵢ†)`. -/
noncomputable def drift (κ : Fin d → ℝ) (i : Fin d) :
    lpFiniteModes (Occ d) →ₗ[ℂ] lpFiniteModes (Occ d) :=
  ((Real.sqrt (κ i / 2) : ℝ) : ℂ) • (cre i + ann i)

/-! ### The algebraic identities of a mode -/













/-! ## The comparison operator -/









/-! ## The Hamiltonian -/









end FockCanonical

end BookProof.NavierStokesFlow



/-!
# The continuum limit: the second-quantized Hamiltonian on a parcel sector

`BookProof.ChapterNavierStokesFockEsa` proves essential self-adjointness of the
transformed (Lagrangian) Navier–Stokes Hamiltonian on the Fock space of a Fock
space in the occupation-number representation, where the one-parcel symbol is
*diagonal* in the chosen mode basis.  The genuinely continuum situation is the
opposite one: the one-parcel operator is multiplication by a field `w` on the
parcel domain `Ω`, so it has **continuous spectrum** and no eigenvectors at all,
and the second-quantized Hamiltonian

`ĥ = ∫_Ω w(ξ) a†(ξ) a(ξ) dξ`

acts on the `n`-parcel sector `L²(Ωⁿ)` of the Fock space as multiplication by
the total energy `E(ξ₁,…,ξₙ) = ∑ₖ w(ξₖ)`.

This module proves essential self-adjointness in that situation.

* `boundedEnergyCore` — the core of states supported where the energy is
  bounded, together with `boundedEnergyCore_dense`: it is a dense domain.
* `multOp` — multiplication by a real measurable function on that core, with
  `multOp_isSymmetricDom`.
* `multOp_hasZeroDeficiencyOn` — **the headline: multiplication by an arbitrary
  real measurable function is essentially self-adjoint on the bounded-energy
  core.**  Unlike the occupation-number picture this covers operators with
  purely continuous spectrum.  The argument tests the deficiency identity
  against the truncations of `(g ∓ i)w` itself.
* `sectorEnergy`, `sectorHamiltonian_hasZeroDeficiencyOn` — the application: on
  the `n`-parcel sector of the continuum Fock space over the infinite continuous
  domain `ℝ`, the second-quantized Hamiltonian `∫ w(ξ)a†(ξ)a(ξ)dξ` — that is,
  multiplication by `∑ₖ w(ξₖ)` — is essentially self-adjoint.
-/

open MeasureTheory

namespace BookProof.NavierStokesFlow

namespace FockContinuum

open FullEsa

variable {X : Type*} [MeasurableSpace X]

/-! ## The bounded-energy core -/

/-- The states supported (almost everywhere) where the energy `g` is bounded:
the natural core of the multiplication operator. -/
def boundedEnergyCore (μ : Measure X) (g : X → ℝ) : Submodule ℂ (Lp ℂ 2 μ) where
  carrier := {f | ∃ n : ℕ, ∀ᵐ x ∂μ, ¬ (|g x| ≤ (n : ℝ)) → (f : X → ℂ) x = 0}
  add_mem' := by
    rintro f h ⟨n, hn⟩ ⟨m, hm⟩
    refine ⟨max n m, ?_⟩
    filter_upwards [hn, hm, Lp.coeFn_add f h] with x hx hy hadd hbig
    have hn' : ¬ (|g x| ≤ (n : ℝ)) := fun hle =>
      hbig (le_trans hle (by exact_mod_cast Nat.cast_le.2 (le_max_left n m)))
    have hm' : ¬ (|g x| ≤ (m : ℝ)) := fun hle =>
      hbig (le_trans hle (by exact_mod_cast Nat.cast_le.2 (le_max_right n m)))
    rw [hadd, Pi.add_apply, hx hn', hy hm', add_zero]
  zero_mem' := by
    refine ⟨0, ?_⟩
    filter_upwards [Lp.coeFn_zero (E := ℂ) (p := 2) (μ := μ)] with x hx _
    rw [hx]; rfl
  smul_mem' := by
    rintro c f ⟨n, hn⟩
    refine ⟨n, ?_⟩
    filter_upwards [hn, Lp.coeFn_smul c f] with x hx hsmul hbig
    rw [hsmul, Pi.smul_apply, hx hbig, smul_zero]



/-! ### The core is dense -/

/-- Truncating a state to the region where the energy is at most `n` converges
to the state in `L²`: the tail `∫_{|g|>n} |f|²` vanishes by dominated
convergence. -/
theorem tendsto_eLpNorm_indicator_compl (μ : Measure X) {g : X → ℝ} (hg : Measurable g)
    (f : Lp ℂ 2 μ) :
    Filter.Tendsto
      (fun n : ℕ => eLpNorm ({x | |g x| ≤ (n : ℝ)}ᶜ.indicator ((f : X → ℂ))) 2 μ)
      Filter.atTop (nhds 0) := by
  have hmeasS : ∀ n : ℕ, MeasurableSet ({x | |g x| ≤ (n : ℝ)}ᶜ) :=
    fun n => (measurableSet_le hg.abs measurable_const).compl
  have hrw : ∀ n : ℕ, eLpNorm ({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) 2 μ
      = (∫⁻ x, ‖({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) x‖ₑ ^ (2 : ℝ) ∂μ)
          ^ (1 / (2 : ℝ)) := by
    intro n
    rw [eLpNorm_eq_lintegral_rpow_enorm_toReal (by norm_num) (by norm_num),
      show ((2 : ENNReal).toReal) = (2 : ℝ) by norm_num]
  simp_rw [hrw]
  have hlim : Filter.Tendsto
      (fun n : ℕ => ∫⁻ x, ‖({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) x‖ₑ ^ (2 : ℝ) ∂μ)
      Filter.atTop (nhds 0) := by
    have hdom : ∀ n : ℕ,
        (fun x => ‖({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) x‖ₑ ^ (2 : ℝ))
          ≤ᵐ[μ] fun x => ‖(f : X → ℂ) x‖ₑ ^ (2 : ℝ) := by
      intro n
      filter_upwards with x
      by_cases h : x ∈ ({x | |g x| ≤ (n : ℝ)}ᶜ)
      · rw [Set.indicator_of_mem h]
      · rw [Set.indicator_of_notMem h]; simp
    have hbdd : ∫⁻ x, ‖(f : X → ℂ) x‖ₑ ^ (2 : ℝ) ∂μ ≠ ⊤ := by
      intro hcon
      have h := Lp.eLpNorm_ne_top f
      rw [eLpNorm_eq_lintegral_rpow_enorm_toReal (by norm_num) (by norm_num)] at h
      apply h
      rw [show ((2 : ENNReal).toReal) = (2 : ℝ) by norm_num, hcon]
      exact ENNReal.top_rpow_of_pos (by positivity)
    have hae : ∀ᵐ x ∂μ, Filter.Tendsto
        (fun n : ℕ => ‖({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) x‖ₑ ^ (2 : ℝ))
        Filter.atTop (nhds 0) := by
      filter_upwards with x
      obtain ⟨N, hN⟩ := exists_nat_ge |g x|
      refine Filter.Tendsto.congr' ?_ tendsto_const_nhds (f₁ := fun _ : ℕ => (0 : ENNReal))
      filter_upwards [Filter.eventually_ge_atTop N] with n hn
      have hx : x ∈ {x | |g x| ≤ (n : ℝ)} := le_trans hN (by exact_mod_cast hn)
      rw [Set.indicator_of_notMem (by simpa using hx)]
      simp
    have hdct := tendsto_lintegral_of_dominated_convergence' (μ := μ) (f := fun _ => (0 : ENNReal))
      (fun x => ‖(f : X → ℂ) x‖ₑ ^ (2 : ℝ))
      (fun n => (((Lp.aestronglyMeasurable f).indicator (hmeasS n)).enorm).pow_const _)
      hdom hbdd hae
    simpa using hdct
  simpa using ((ENNReal.continuous_rpow_const (y := 1 / (2 : ℝ))).tendsto 0).comp hlim

/-- **The bounded-energy core is dense.**  Every square-integrable state is the
`L²`-limit of its truncations to the regions where the energy is bounded, so the
core is a genuine dense domain for the multiplication operator. -/
theorem boundedEnergyCore_dense (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    Dense ((boundedEnergyCore μ g : Submodule ℂ (Lp ℂ 2 μ)) : Set (Lp ℂ 2 μ)) := by
  have hmeasS : ∀ n : ℕ, MeasurableSet {x | |g x| ≤ (n : ℝ)} :=
    fun n => measurableSet_le hg.abs measurable_const
  intro f
  refine mem_closure_iff_seq_limit.2
    ⟨fun n => ((Lp.memLp f).indicator (hmeasS n)).toLp _, fun n => ?_, ?_⟩
  · refine ⟨n, ?_⟩
    filter_upwards [((Lp.memLp f).indicator (hmeasS n)).coeFn_toLp] with x hx hbig
    rw [hx, Set.indicator_of_notMem (by simpa using hbig)]
  · have heq : ∀ n : ℕ,
        eLpNorm ({x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ) - (f : X → ℂ)) 2 μ
          = eLpNorm ({x | |g x| ≤ (n : ℝ)}ᶜ.indicator ((f : X → ℂ))) 2 μ := by
      intro n
      have hfun : {x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ) - (f : X → ℂ)
          = -({x | |g x| ≤ (n : ℝ)}ᶜ.indicator (f : X → ℂ)) := by
        funext x
        by_cases h : x ∈ {x | |g x| ≤ (n : ℝ)}
        · simp [Set.indicator_of_mem h,
            Set.indicator_of_notMem (show x ∉ {x | |g x| ≤ (n : ℝ)}ᶜ by simpa using h)]
        · simp [Set.indicator_of_notMem h,
            Set.indicator_of_mem (show x ∈ {x | |g x| ≤ (n : ℝ)}ᶜ from h)]
      rw [hfun, eLpNorm_neg]
    have hten : Filter.Tendsto
        (fun n : ℕ => eLpNorm ({x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ) - (f : X → ℂ)) 2 μ)
        Filter.atTop (nhds 0) := by
      simp_rw [heq]
      exact tendsto_eLpNorm_indicator_compl μ hg f
    have h := (Lp.tendsto_Lp_iff_tendsto_eLpNorm''
      (fun n : ℕ => {x | |g x| ≤ (n : ℝ)}.indicator (f : X → ℂ))
      (fun n => (Lp.memLp f).indicator (hmeasS n)) (f : X → ℂ) (Lp.memLp f)).2 hten
    rwa [Lp.toLp_coeFn] at h

/-- Multiplying a bounded-energy state by the energy stays square-integrable. -/
theorem memLp_mul {μ : Measure X} {g : X → ℝ} (hg : Measurable g) {f : Lp ℂ 2 μ}
    (hf : f ∈ boundedEnergyCore μ g) :
    MemLp (fun x => (g x : ℂ) * (f : X → ℂ) x) 2 μ := by
  obtain ⟨n, hn⟩ := hf
  have hmeas : AEStronglyMeasurable (fun x => (g x : ℂ) * (f : X → ℂ) x) μ :=
    (Complex.measurable_ofReal.comp hg).aestronglyMeasurable.mul (Lp.aestronglyMeasurable f)
  have hbound : ∀ᵐ x ∂μ, ‖(g x : ℂ) * (f : X → ℂ) x‖ ≤ ((n : ℝ)) * ‖(f : X → ℂ) x‖ := by
    filter_upwards [hn] with x hx
    by_cases h : |g x| ≤ (n : ℝ)
    · rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
      exact mul_le_mul_of_nonneg_right h (norm_nonneg _)
    · rw [hx h]; simp
  exact MemLp.of_le_mul (Lp.memLp f) hmeas hbound

theorem mul_mem_boundedEnergyCore {μ : Measure X} {g : X → ℝ} (hg : Measurable g)
    {f : Lp ℂ 2 μ} (hf : f ∈ boundedEnergyCore μ g) :
    (memLp_mul hg hf).toLp _ ∈ boundedEnergyCore μ g := by
  obtain ⟨n, hn⟩ := hf
  refine ⟨n, ?_⟩
  filter_upwards [hn,
    (memLp_mul hg (⟨n, hn⟩ : f ∈ boundedEnergyCore μ g)).coeFn_toLp] with x hx hcoe hbig
  rw [hcoe, hx hbig, mul_zero]

/-- **Multiplication by a real measurable function** on the bounded-energy core:
the second-quantized Hamiltonian in the configuration representation. -/
noncomputable def multOp (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    boundedEnergyCore μ g →ₗ[ℂ] boundedEnergyCore μ g where
  toFun f := ⟨(memLp_mul hg f.2).toLp _, mul_mem_boundedEnergyCore hg f.2⟩
  map_add' f h := by
    refine Subtype.ext (Lp.ext ?_)
    simp only [Submodule.coe_add]
    filter_upwards [(memLp_mul hg (show ((f : Lp ℂ 2 μ) + (h : Lp ℂ 2 μ)) ∈ boundedEnergyCore μ g
        from (f + h).2)).coeFn_toLp,
      (memLp_mul hg f.2).coeFn_toLp, (memLp_mul hg h.2).coeFn_toLp,
      Lp.coeFn_add ((f : Lp ℂ 2 μ)) ((h : Lp ℂ 2 μ)),
      Lp.coeFn_add ((memLp_mul hg f.2).toLp _) ((memLp_mul hg h.2).toLp _)] with x h1 h2 h3 h4 h5
    rw [h1, h5]
    simp only [Pi.add_apply]
    rw [h2, h3, h4]
    simp only [Pi.add_apply]
    ring
  map_smul' c f := by
    refine Subtype.ext (Lp.ext ?_)
    simp only [Submodule.coe_smul, RingHom.id_apply]
    filter_upwards [(memLp_mul hg (show (c • (f : Lp ℂ 2 μ)) ∈ boundedEnergyCore μ g
        from (c • f).2)).coeFn_toLp,
      (memLp_mul hg f.2).coeFn_toLp, Lp.coeFn_smul c ((f : Lp ℂ 2 μ)),
      Lp.coeFn_smul c ((memLp_mul hg f.2).toLp _)] with x h1 h2 h3 h4
    rw [h1, h4]
    simp only [Pi.smul_apply, smul_eq_mul]
    rw [h2, h3]
    simp only [Pi.smul_apply, smul_eq_mul]
    ring







/-! ## Essential self-adjointness -/



/-! ## The `n`-parcel sector of the continuum Fock space -/

section Sector









end Sector

end FockContinuum

end BookProof.NavierStokesFlow



/-!
# The transformed Navier–Stokes Hamiltonian in the Lagrangian momentum
representation: essential self-adjointness with continuous spectrum

`BookProof.ChapterNavierStokesLagrangianEsa` sets up the untruncated Lagrangian
data `LagrangianFullData` — the parcel momenta `Pᵢ`, the viscous gradients `Qᵢ`,
the force drift generators `Dᵢ` and the volume-preservation constraint `C` — and
proves that the transformed Hamiltonian

`ĥ_full = ½∑ᵢPᵢ² + ν∑ᵢQᵢ² + ∑ᵢfᵢDᵢ + C`

is symmetric with positive second-order part, essentially self-adjoint whenever
the constituents admit a *total family of common eigenvectors*.

That criterion is a discrete-spectrum criterion: it needs eigenvectors.  The
Lagrangian momentum representation of a *continuum* fluid has none — the
constituents are multiplication operators by the momentum coordinates, whose
spectrum is purely continuous.  This module closes that gap.

## What is proved here

* `DominatedOn` and the multiplication operator `mulD` — multiplication by a
  real measurable symbol `h` on the bounded-energy core of a *scale* function
  `g`, available whenever `h` is bounded on the level sets of `g`, with its
  algebra (`mulD_comp`, `mulD_add`, `mulD_sum`, `mulD_real_smul`).
* `mulD_hasZeroDeficiencyOn` — **multiplication by any symbol dominated by the
  scale is essentially self-adjoint on the bounded-energy core of the scale.**
  This generalizes `FockContinuum.multOp_hasZeroDeficiencyOn`, where symbol and
  scale had to coincide, and it is what allows *all four* constituents of the
  transformed Hamiltonian to live on one common core.
* `LagSymbols` — the Lagrangian momentum representation itself: arbitrary
  measurable real symbols `Pᵢ, Qᵢ, Dᵢ, C` on a measure space of momentum
  configurations, with no boundedness assumption whatsoever, and the common
  core `boundedEnergyCore μ S.scale`.
* `LagSymbols.data` — the resulting `LagrangianFullData`, so everything proved
  about the abstract transformed operator (symmetry, positivity of the advective
  and viscous terms, transfer along the change of variables) applies verbatim.
* `LagSymbols.hFull_eq_mulD` — **the transformed Hamiltonian is multiplication
  by the total Lagrangian symbol** `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`.
* `LagSymbols.hFull_hasZeroDeficiencyOn` — **the headline: the untruncated
  transformed Navier–Stokes Hamiltonian is essentially self-adjoint in the
  Lagrangian momentum representation**, for arbitrary measurable symbols, with
  in general purely continuous spectrum and no eigenvectors at all.
* `norm_mulD_ge`, `mulD_not_bounded` — the lower bound that makes such an
  operator genuinely unbounded whenever its symbol is.

The second-quantized realization on the continuum Fock space of all
parcel-number sectors — where this criterion is applied to the transformed
Navier–Stokes Hamiltonian itself — is in
`BookProof.ChapterNavierStokesFockParcels`.

## Scope

Nothing here claims global existence for Navier–Stokes, and nothing here claims
essential self-adjointness of the *Eulerian* continuum generator: what is proved
is essential self-adjointness of the transformed operator in the Lagrangian
momentum representation, which by
`NavierStokesFlow.NSFullData.hasZeroDeficiencyOn_of_lagrangian` transports back
along a unitary change of variables only when such a change of variables is
supplied.
-/

open MeasureTheory

namespace BookProof.NavierStokesFlow

namespace FockLagrangian

open FullEsa FockContinuum

variable {X : Type*} [MeasurableSpace X]

/-! ## Symbols dominated on the level sets of a scale function -/

/-- The symbol `h` is **dominated on the level sets of the scale `g`**: on the
region where `|g| ≤ n` the symbol `h` is bounded.  This is exactly what is needed
for multiplication by `h` to preserve the bounded-energy core of `g`. -/
def DominatedOn (μ : Measure X) (g h : X → ℝ) : Prop :=
  ∀ n : ℕ, ∃ M : ℝ, 0 ≤ M ∧ ∀ᵐ x ∂μ, |g x| ≤ (n : ℝ) → |h x| ≤ M

theorem DominatedOn.rfl' (μ : Measure X) (g : X → ℝ) : DominatedOn μ g g :=
  fun n => ⟨n, Nat.cast_nonneg n, Filter.Eventually.of_forall fun _ hx => hx⟩









theorem DominatedOn.of_abs_le {μ : Measure X} {g h k : X → ℝ} (d : DominatedOn μ g k)
    (hle : ∀ᵐ x ∂μ, |h x| ≤ |k x|) : DominatedOn μ g h := by
  intro n
  obtain ⟨M, hM, hx⟩ := d n
  refine ⟨M, hM, ?_⟩
  filter_upwards [hx, hle] with x h1 h2 hb
  exact le_trans h2 (h1 hb)



/-! ## Multiplication by a dominated symbol on the bounded-energy core -/

/-- Multiplying a bounded-energy state by a dominated symbol stays
square-integrable. -/
theorem memLp_mulD {μ : Measure X} {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) {f : Lp ℂ 2 μ} (hf : f ∈ boundedEnergyCore μ g) :
    MemLp (fun x => (h x : ℂ) * (f : X → ℂ) x) 2 μ := by
  obtain ⟨n, hn⟩ := hf
  obtain ⟨M, hM, hMx⟩ := hdom n
  have hmeas : AEStronglyMeasurable (fun x => (h x : ℂ) * (f : X → ℂ) x) μ :=
    (Complex.measurable_ofReal.comp hh).aestronglyMeasurable.mul (Lp.aestronglyMeasurable f)
  have hbound : ∀ᵐ x ∂μ, ‖(h x : ℂ) * (f : X → ℂ) x‖ ≤ M * ‖(f : X → ℂ) x‖ := by
    filter_upwards [hn, hMx] with x hx hMb
    by_cases hb : |g x| ≤ (n : ℝ)
    · rw [norm_mul, Complex.norm_real, Real.norm_eq_abs]
      exact mul_le_mul_of_nonneg_right (hMb hb) (norm_nonneg _)
    · rw [hx hb]
      simp
  exact MemLp.of_le_mul (Lp.memLp f) hmeas hbound

theorem mulD_mem_core {μ : Measure X} {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) {f : Lp ℂ 2 μ} (hf : f ∈ boundedEnergyCore μ g) :
    (memLp_mulD hh hdom hf).toLp _ ∈ boundedEnergyCore μ g := by
  obtain ⟨n, hn⟩ := hf
  refine ⟨n, ?_⟩
  filter_upwards [hn, (memLp_mulD hh hdom (⟨n, hn⟩ : f ∈ boundedEnergyCore μ g)).coeFn_toLp]
    with x hx hcoe hbig
  rw [hcoe, hx hbig, mul_zero]

/-- **Multiplication by a dominated real symbol** on the bounded-energy core of
the scale `g`.  Unlike `FockContinuum.multOp` the symbol need not be the scale
itself, so several different symbols act on one and the same core. -/
noncomputable def mulD (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) :
    boundedEnergyCore μ g →ₗ[ℂ] boundedEnergyCore μ g where
  toFun f := ⟨(memLp_mulD hh hdom f.2).toLp _, mulD_mem_core hh hdom f.2⟩
  map_add' f k := by
    refine Subtype.ext (Lp.ext ?_)
    simp only [Submodule.coe_add]
    filter_upwards [(memLp_mulD hh hdom
        (show ((f : Lp ℂ 2 μ) + (k : Lp ℂ 2 μ)) ∈ boundedEnergyCore μ g from (f + k).2)).coeFn_toLp,
      (memLp_mulD hh hdom f.2).coeFn_toLp, (memLp_mulD hh hdom k.2).coeFn_toLp,
      Lp.coeFn_add ((f : Lp ℂ 2 μ)) ((k : Lp ℂ 2 μ)),
      Lp.coeFn_add ((memLp_mulD hh hdom f.2).toLp _)
        ((memLp_mulD hh hdom k.2).toLp _)] with x h1 h2 h3 h4 h5
    rw [h1, h5]
    simp only [Pi.add_apply]
    rw [h2, h3, h4]
    simp only [Pi.add_apply]
    ring
  map_smul' c f := by
    refine Subtype.ext (Lp.ext ?_)
    simp only [Submodule.coe_smul, RingHom.id_apply]
    filter_upwards [(memLp_mulD hh hdom
        (show (c • (f : Lp ℂ 2 μ)) ∈ boundedEnergyCore μ g from (c • f).2)).coeFn_toLp,
      (memLp_mulD hh hdom f.2).coeFn_toLp, Lp.coeFn_smul c ((f : Lp ℂ 2 μ)),
      Lp.coeFn_smul c ((memLp_mulD hh hdom f.2).toLp _)] with x h1 h2 h3 h4
    rw [h1, h4]
    simp only [Pi.smul_apply, smul_eq_mul]
    rw [h2, h3]
    simp only [Pi.smul_apply, smul_eq_mul]
    ring

theorem mulD_coeFn (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) (f : boundedEnergyCore μ g) :
    (((mulD μ hh hdom f : boundedEnergyCore μ g) : Lp ℂ 2 μ) : X → ℂ)
      =ᵐ[μ] fun x => (h x : ℂ) * ((f : Lp ℂ 2 μ) : X → ℂ) x :=
  (memLp_mulD hh hdom f.2).coeFn_toLp



/-- The multiplication operator is symmetric on the core. -/
theorem mulD_isSymmetricDom (μ : Measure X) {g h : X → ℝ} (hh : Measurable h)
    (hdom : DominatedOn μ g h) : IsSymmetricDom (mulD μ hh hdom) := by
  intro x y
  rw [L2.inner_def, L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [mulD_coeFn μ hh hdom x, mulD_coeFn μ hh hdom y] with a hx hy
  simp only [RCLike.inner_apply, hx, hy, map_mul, Complex.conj_ofReal]
  ring







/-! ### Flexible forms of the algebra, with the target symbol given explicitly -/







/-! ## Essential self-adjointness of a dominated multiplication operator -/



/-! ### Lower bounds on the multiplication operator, and unboundedness -/





/-! ### No eigenvectors: continuity of the spectrum -/



/-! ## The Lagrangian momentum representation -/

/-- **The Lagrangian momentum representation of the transformed Navier–Stokes
data.**  The parcel momenta `Pᵢ`, the viscous gradients `Qᵢ`, the force drift
generators `Dᵢ` and the volume-preservation constraint `C` are here *arbitrary
real measurable symbols* on a measure space `X` of momentum configurations —
nothing is assumed bounded, and the resulting operators have in general purely
continuous spectrum. -/
structure LagSymbols (X : Type*) [MeasurableSpace X] (μ : Measure X) where
  /-- The parcel-momentum symbols. -/
  P : Fin 3 → X → ℝ
  /-- The viscous-gradient symbols. -/
  Q : Fin 3 → X → ℝ
  /-- The drift-generator symbols. -/
  Dr : Fin 3 → X → ℝ
  /-- The volume-preservation constraint symbol. -/
  cfun : X → ℝ
  /-- The external force. -/
  force : Fin 3 → ℝ
  /-- The kinematic viscosity. -/
  nu : ℝ
  nu_nonneg : 0 ≤ nu
  P_meas : ∀ i, Measurable (P i)
  Q_meas : ∀ i, Measurable (Q i)
  Dr_meas : ∀ i, Measurable (Dr i)
  c_meas : Measurable cfun

namespace LagSymbols

variable {μ : Measure X} (S : LagSymbols X μ)

/-- The **scale**: the sum of the absolute values of all the symbols.  Its
bounded-energy core is the common domain on which all four constituents of the
transformed Hamiltonian act. -/
def scale : X → ℝ := fun x =>
  (∑ i : Fin 3, |S.P i x|) + (∑ i : Fin 3, |S.Q i x|) + (∑ i : Fin 3, |S.Dr i x|) + |S.cfun x|



theorem scale_meas : Measurable S.scale := by
  refine (((Finset.univ.measurable_sum fun i _ => (S.P_meas i).abs).add
    (Finset.univ.measurable_sum fun i _ => (S.Q_meas i).abs)).add
    (Finset.univ.measurable_sum fun i _ => (S.Dr_meas i).abs)).add S.c_meas.abs

/-- Every symbol of the family is dominated by the scale. -/
theorem dominated_of_abs_le {h : X → ℝ} (hle : ∀ x, |h x| ≤ S.scale x) :
    DominatedOn μ S.scale h :=
  (DominatedOn.rfl' μ S.scale).of_abs_le
    (Filter.Eventually.of_forall fun x =>
      le_trans (hle x) (le_abs_self (S.scale x)))

theorem P_dom (i : Fin 3) : DominatedOn μ S.scale (S.P i) := by
  refine S.dominated_of_abs_le fun x => ?_
  have h1 : |S.P i x| ≤ ∑ j : Fin 3, |S.P j x| :=
    Finset.single_le_sum (f := fun j => |S.P j x|) (fun j _ => abs_nonneg _)
      (Finset.mem_univ i)
  have h2 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Q j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h3 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Dr j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h4 : (0 : ℝ) ≤ |S.cfun x| := abs_nonneg _
  simp only [scale]
  linarith

theorem Q_dom (i : Fin 3) : DominatedOn μ S.scale (S.Q i) := by
  refine S.dominated_of_abs_le fun x => ?_
  have h1 : |S.Q i x| ≤ ∑ j : Fin 3, |S.Q j x| :=
    Finset.single_le_sum (f := fun j => |S.Q j x|) (fun j _ => abs_nonneg _)
      (Finset.mem_univ i)
  have h2 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.P j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h3 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Dr j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h4 : (0 : ℝ) ≤ |S.cfun x| := abs_nonneg _
  simp only [scale]
  linarith

theorem Dr_dom (i : Fin 3) : DominatedOn μ S.scale (S.Dr i) := by
  refine S.dominated_of_abs_le fun x => ?_
  have h1 : |S.Dr i x| ≤ ∑ j : Fin 3, |S.Dr j x| :=
    Finset.single_le_sum (f := fun j => |S.Dr j x|) (fun j _ => abs_nonneg _)
      (Finset.mem_univ i)
  have h2 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.P j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h3 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Q j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h4 : (0 : ℝ) ≤ |S.cfun x| := abs_nonneg _
  simp only [scale]
  linarith

theorem c_dom : DominatedOn μ S.scale S.cfun := by
  refine S.dominated_of_abs_le fun x => ?_
  have h1 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.P j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h2 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Q j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  have h3 : (0 : ℝ) ≤ ∑ j : Fin 3, |S.Dr j x| := Finset.sum_nonneg fun j _ => abs_nonneg _
  simp only [scale]
  linarith

/-- The common domain: the bounded-scale core. -/
def core : Submodule ℂ (Lp ℂ 2 μ) := boundedEnergyCore μ S.scale

theorem core_dense : Dense ((S.core : Submodule ℂ (Lp ℂ 2 μ)) : Set (Lp ℂ 2 μ)) :=
  boundedEnergyCore_dense μ S.scale_meas

/-- The parcel-momentum operators. -/
noncomputable def Pop (i : Fin 3) : S.core →ₗ[ℂ] S.core := mulD μ (S.P_meas i) (S.P_dom i)

/-- The viscous-gradient operators. -/
noncomputable def Qop (i : Fin 3) : S.core →ₗ[ℂ] S.core := mulD μ (S.Q_meas i) (S.Q_dom i)

/-- The drift generators. -/
noncomputable def Drop (i : Fin 3) : S.core →ₗ[ℂ] S.core := mulD μ (S.Dr_meas i) (S.Dr_dom i)

/-- The volume-preservation constraint operator. -/
noncomputable def Cop : S.core →ₗ[ℂ] S.core := mulD μ S.c_meas S.c_dom

/-- **The Lagrangian momentum representation as untruncated transformed
Navier–Stokes data.**  Everything proved about `LagrangianFullData` — symmetry,
positivity of the advective and viscous quadratic forms, transfer of essential
self-adjointness along the change of variables — applies to it. -/
noncomputable def data : LagrangianEsa.LagrangianFullData (Lp ℂ 2 μ) where
  D := S.core
  P := S.Pop
  Q := S.Qop
  drive := S.Drop
  force := S.force
  constraintOp := S.Cop
  nu := S.nu
  dense := S.core_dense
  P_symm i := mulD_isSymmetricDom μ (S.P_meas i) (S.P_dom i)
  Q_symm i := mulD_isSymmetricDom μ (S.Q_meas i) (S.Q_dom i)
  drive_symm i := mulD_isSymmetricDom μ (S.Dr_meas i) (S.Dr_dom i)
  constraint_symm := mulD_isSymmetricDom μ S.c_meas S.c_dom
  nu_nonneg := S.nu_nonneg

/-- **The total Lagrangian symbol** `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`: the classical
energy of the transformed Hamiltonian in the momentum representation. -/
noncomputable def total : X → ℝ := fun x =>
  (1 / 2) * (∑ i : Fin 3, (S.P i x) ^ 2) + S.nu * (∑ i : Fin 3, (S.Q i x) ^ 2)
    + (∑ i : Fin 3, S.force i * S.Dr i x) + S.cfun x





/-! ### The transformed Hamiltonian is multiplication by the total symbol -/





































end LagSymbols

end FockLagrangian

end BookProof.NavierStokesFlow



/-!
# The Navier–Stokes Hamiltonian of a many-mode field, and its Faris–Lavine bounds

`BookProof.ChapterNavierStokesHermiteFarisLavine` proves the two Faris–Lavine
inequalities for the Navier–Stokes fiber Hamiltonian of **one** degree of
freedom.  This module carries out the second quantization: the field has `d`
modes, each with its own fiber coordinate `uᵢ`, its own momentum
`πᵢ = -i ∂/∂uᵢ` and its own linear advection field `Vᵢ(u) = κᵢ uᵢ`, and the
Hamiltonian and the comparison operator are the sums over the modes

`Ĥ = ∑ᵢ ½(πᵢ Vᵢ + Vᵢ πᵢ)`,  `N̂ = ∑ᵢ (πᵢ² + Vᵢ²) + I`.

In the Hermite (occupation-number) basis of the modes, the Hilbert space is
`ℓ²(ℕᵈ)` — the Fock space of the `d`-mode boson field — the states are labelled
by occupation configurations `α : Fin d → ℕ`, the comparison operator is
multiplication by the total energy

`Σ(α) = ∑ᵢ κᵢ(2αᵢ + 1) + 1`  (`fockSym`),

and the Hamiltonian is the sum over the modes of the pair
creation/annihilation ("Bogoliubov") terms `(iκᵢ/2)(aᵢ†² − aᵢ²)`, each of which
hops `α ↦ α ± 2eᵢ`.

Each mode contributes an abstract shift Hamiltonian in the sense of
`BookProof.ChapterNavierStokesShiftHamiltonian` — with the **total** symbol `Σ`
as its comparison symbol — so the one-mode analysis applies to each summand, and
the many-mode inequalities follow by finitely many applications of
`(∑ᵢ aᵢ)² ≤ d ∑ᵢ aᵢ²`.

## What is proved

* `fockH_symmetricOn` — `Ĥ` is symmetric on the maximal domain of `N̂`;
* `fockH_relative_bound` — `‖Ĥx‖² ≤ (d²/2)‖N̂x‖² + 2d(∑ᵢκᵢ²)‖x‖²`;
* `fockH_commForm_bound` — `|⟪x, i[Ĥ, N̂]x⟫| ≤ (∑ᵢ(2κᵢ + 4κᵢ²)) ⟪x, N̂x⟫`;
* `fockH_essentiallySelfAdjointOn_core` — hence `Ĥ` is essentially self-adjoint
  on the finite-configuration core of the many-mode Fock space.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace FockManyMode

open LpNat FarisLavine IkebeKato ShiftHamiltonian

/-- An occupation-number configuration of the `d` field modes: `α i` quanta in
the Hermite level of the mode `i`.  `ℓ²(Occ d)` is the Fock space of the `d`-mode
boson field. -/
abbrev Occ (d : ℕ) := Fin d → ℕ

variable {d : ℕ} {κ : Fin d → ℝ}









/-! ## The mode-wise shift data -/





















/-! ## The many-mode Hamiltonian -/







/-! ## The first Faris–Lavine inequality -/



/-! ## The second Faris–Lavine inequality -/





/-! ## The commutator is genuinely non-zero -/

























/-! ## Essential self-adjointness -/



end FockManyMode

end BookProof.NavierStokesFlow



/-!
# The Fock space of a Fock space, and its ladder operators

The Lagrangian form of the Navier–Stokes Hamiltonian of
`BookProof.ChapterNavierStokesLagrangianEsa` is a *second* quantization: the
Eulerian field `u` is already an operator on a Fock space, and passing to the
parcel variables `X(ξ)` — one field-carrying parcel for each label `ξ` in a
continuous domain — quantizes the parcels themselves.  The state space is
therefore a Fock space **whose one-particle space is itself a Fock space**, and
the Hamiltonian is *quadratic* in the outer (parcel) creation and annihilation
operators.

This module builds that state space concretely, in the occupation-number
representation, together with both levels of ladder operators.

* `lpDiag`, `lpBasis` — a general diagonal operator with a real symbol on the
  finitely supported modes of `ℓ²(ι)`, its eigenbasis, symmetry, essential
  self-adjointness (`lpDiag_hasZeroDeficiencyOn`) and unboundedness
  (`lpDiag_not_bounded`).
* `Conf M = M →₀ ℕ`, `FockL2 M = ℓ²(Conf M)`, `FockDom M` — the Fock space over
  the mode index `M` in the occupation-number representation and its dense
  domain of finite-particle, finite-mode states.
* `annih m`, `creat m` — the annihilation and creation operators, with
  `annih_basis`, `creat_basis` (the usual `√n` factors), `creat_adjoint`
  (`⟪a†v, w⟫ = ⟪v, a w⟫`) and the canonical commutation relations
  `ccr_same`, `ccr_ne`.
* `numberOp m = a†ₘ aₘ` and `numberOp_basis` — the mode occupation operator.
* `FockOfFockL2 J K = FockL2 (J × Conf K)` — **the Fock space of a Fock space**:
  the outer one-particle modes are indexed by a parcel mode `j : J` *together
  with* an inner Fock (occupation) state `c : Conf K`.  `outerOneParticle` shows
  that the outer creation operator applied to the vacuum creates exactly one
  parcel carrying the inner Fock state `c`.

The Hamiltonian itself, its integral over the continuous parcel domain and its
essential self-adjointness are in `BookProof.ChapterNavierStokesFockEsa`.
-/

namespace BookProof.NavierStokesFlow

namespace FockOfFock

open FullEsa

/-! ## Finitely supported coefficient vectors in `ℓ²(ι)` -/

section Coeff

variable {ι : Type*}











/-- The canonical basis state `e_i` of the finite-mode domain. -/
noncomputable def lpBasis [DecidableEq ι] (i : ι) : lpFiniteModes ι :=
  ⟨lp.single 2 i 1, lpSingle_mem_lpFiniteModes i 1⟩









end Coeff

/-! ## Diagonal operators with a real symbol -/

section Diagonal

variable {ι : Type*}















end Diagonal

/-! ## The Fock space in the occupation-number representation -/

section Fock

variable {M : Type*} [DecidableEq M]

/-- An occupation-number configuration: finitely many modes excited, each
finitely often. -/
abbrev Conf (M : Type*) := M →₀ ℕ

/-- The bosonic Fock space over the mode index `M`, in the occupation-number
representation. -/
abbrev FockL2 (M : Type*) := lp (fun _ : Conf M => ℂ) 2

/-- The dense domain of finite-particle, finite-mode states. -/
abbrev FockDom (M : Type*) : Submodule ℂ (FockL2 M) := lpFiniteModes (Conf M)





/-- The occupation-number basis state `|n⟩`. -/
noncomputable def fockBasis (n : Conf M) : FockDom M := lpBasis n



/-- The vacuum `|0⟩`. -/
noncomputable def vacuum : FockDom M := fockBasis 0

/-! ### Annihilation and creation -/





























/-! ### The canonical commutation relations -/





/-! ### Adjointness -/





end Fock

/-! ## The Fock space of a Fock space -/

section FockOfFockSpace

variable {J K : Type*} [DecidableEq J] [DecidableEq K]









end FockOfFockSpace

end FockOfFock

end BookProof.NavierStokesFlow



/-!
# The canonical pair behind the Navier–Stokes fiber Hamiltonian

`BookProof.ChapterNavierStokesHermiteFarisLavine` proves the two Faris–Lavine
inequalities for a concrete operator `nsH` on `ℓ²(ℕ)` — the `±2`-shift with
amplitudes `w(n) = (κ/2)√((n+1)(n+2))` — and for the diagonal comparison operator
`diagMax (oscSymbol κ)`.  This module verifies that these two operators really
*are* the Navier–Stokes objects they are advertised to be, namely

* `H = ½(π V + V π)`, the symmetrised first-order transport operator, and
* `N = π² + V² + I`, the comparison operator built from the squares of the
  individual non-commuting pieces,

for the canonical pair `π = -i ∂/∂u`, `u` of the fiber and the *linear* advection
field `V(u) = κ u`.  Everything is checked on the finite-mode core
`lpFiniteModes ℕ`, which the Hermite functions span.

## Contents

* `ann`, `cre` — the annihilation and creation operators of the Hermite basis,
  with `[a, a†] = I` (`comm_ann_cre`);
* `mom κ = i√(κ/2)(a† - a)`, `pos κ = (2κ)^{-1/2}(a + a†)`, `drift κ = κ · pos κ`
  — the momentum, the fiber coordinate and the advection field;
* `comm_mom_pos` — **`[π, u] = -i`**: the two are genuinely non-commuting, which
  is the whole point of the Faris–Lavine mechanism;
* `comparison_eq` — **`π² + V² + I = N`**, the diagonal comparison operator of
  the Faris–Lavine chapter;
* `hamiltonian_eq` — **`½(πV + Vπ) = H`**, the `±2`-shift operator of the
  Faris–Lavine chapter;
* `canonical_essentiallySelfAdjointOn_core` — hence the *canonically written*
  Navier–Stokes fiber Hamiltonian `½(πV + Vπ)` is essentially self-adjoint on the
  finite-mode core.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace HermiteCanonical

open LpNat FarisLavine IkebeKato HermiteFarisLavine

/-! ## The core, and states given by their coordinates -/

/-- A finitely supported coordinate sequence as a state of the finite-mode
core. -/
noncomputable def mkCore {X : ℕ → ℂ} (h : (Function.support X).Finite) : lpFiniteModes ℕ :=
  ⟨⟨X, memLpTwo_of_finite_support h⟩, h⟩

@[simp] theorem mkCore_coe {X : ℕ → ℂ} (h : (Function.support X).Finite) (n : ℕ) :
    (((mkCore h : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n = X n := rfl

theorem support_finite (x : lpFiniteModes ℕ) :
    (Function.support (((x : L2I ℕ) : ℕ → ℂ))).Finite := x.2

/-! ## Annihilation and creation -/

/-- `a x` has coordinates `√(n+1) xₙ₊₁`. -/
noncomputable def annFun (X : ℕ → ℂ) : ℕ → ℂ := fun n => (Real.sqrt (n + 1) : ℂ) * X (n + 1)

/-- `a† x` has coordinates `√n xₙ₋₁` (and `0` at `n = 0`, since `√0 = 0`). -/
noncomputable def creFun (X : ℕ → ℂ) : ℕ → ℂ := fun n => (Real.sqrt n : ℂ) * X (n - 1)

theorem support_annFun {X : ℕ → ℂ} (h : (Function.support X).Finite) :
    (Function.support (annFun X)).Finite := by
  refine Set.Finite.subset (h.preimage (f := fun n : ℕ => n + 1) (Set.injOn_of_injective
    (fun a b hab => by omega))) ?_
  intro n hn
  simp only [Function.mem_support, annFun] at hn
  simp only [Set.mem_preimage, Function.mem_support]
  intro h0
  exact hn (by rw [h0, mul_zero])

theorem support_creFun {X : ℕ → ℂ} (h : (Function.support X).Finite) :
    (Function.support (creFun X)).Finite := by
  refine Set.Finite.subset (h.image (fun n : ℕ => n + 1)) ?_
  intro n hn
  simp only [Function.mem_support, creFun] at hn
  have hn0 : n ≠ 0 := by
    intro h0
    apply hn
    simp [h0]
  refine ⟨n - 1, ?_, by simp only []; omega⟩
  simp only [Function.mem_support]
  intro h0
  exact hn (by rw [h0, mul_zero])

/-- **The annihilation operator** of the Hermite basis. -/
noncomputable def ann : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ where
  toFun x := mkCore (support_annFun (support_finite x))
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun n => ?_))
    simp only [mkCore_coe, annFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun n => ?_))
    simp only [mkCore_coe, annFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring

/-- **The creation operator** of the Hermite basis. -/
noncomputable def cre : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ where
  toFun x := mkCore (support_creFun (support_finite x))
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun n => ?_))
    simp only [mkCore_coe, creFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun n => ?_))
    simp only [mkCore_coe, creFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring







/-! ### Coordinates of the quadratic expressions -/















/-! ## The canonical pair and the advection field -/

variable {κ : ℝ}

/-- The momentum `π = i√(κ/2)(a† - a) = -i ∂/∂u`. -/
noncomputable def mom (κ : ℝ) : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ :=
  (Complex.I * (Real.sqrt (κ / 2) : ℂ)) • (cre - ann)

/-- The fiber coordinate `u = (2κ)^(-1/2)(a + a†)`. -/
noncomputable def pos (κ : ℝ) : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ :=
  ((1 / Real.sqrt (2 * κ) : ℝ) : ℂ) • (cre + ann)

/-- The linear advection field `V(u) = κ u = √(κ/2)(a + a†)`. -/
noncomputable def drift (κ : ℝ) : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ :=
  ((Real.sqrt (κ / 2) : ℝ) : ℂ) • (cre + ann)

/-! ### The three algebraic identities of the canonical pair -/







/-! ### Scalars -/

















end HermiteCanonical

end BookProof.NavierStokesFlow



/-!
# The two Faris–Lavine inequalities, verified for the Navier–Stokes generator

Everywhere else on this route the two Faris–Lavine inequalities

* the relative bound `‖H x‖² ≤ a‖N x‖² + b‖x‖²`, and
* the form-commutator bound `± i[H, N] ≤ c N`,

are *hypotheses* on the Hamiltonian.  Here they are **proved**, for a concrete
Hamiltonian in a representation in which the momentum and the fiber coordinate
genuinely do **not** commute — so that the commutator `[H, N]` is genuinely
non-zero (`commForm_ne_zero_of_pos`), and the Faris–Lavine mechanism (the
non-commuting cross terms `π · V` are dominated by the sum of the squares
`π² + V²`) is what makes the argument work.

## The model

On the fiber, the one-particle Navier–Stokes transport operator is the symmetric
first-order operator
`h = ½ (πᵢ Vᵢ + Vᵢ πᵢ)`,
with `πᵢ = -i ∂/∂uᵢ` and with the *linear* advection field `Vᵢ(u) = Mᵢⱼuⱼ + Cᵢ`.
The comparison operator is built, as Faris–Lavine requires, from the squares of
the individual non-commuting pieces:
`N = πᵢπᵢ + Vᵢ(u)Vᵢ(u) + I ≥ I`.

Take one fiber degree of freedom and the linear field `V(u) = κ u` (`κ ≥ 0` the
strain rate).  In the Hermite (harmonic-oscillator) basis `eₙ` of `L²(du)`,
normalised so that
`u = (a + a†)/√(2κ)`, `π = i√(κ/2)(a† - a)` — hence `[π, u] = -i`, `nsComm_pu` —
one has

* `N = π² + V² + I = κ(2n̂ + 1) + I`: **diagonal**, multiplication by the symbol
  `oscSymbol κ n = κ(2n+1) + 1 ≥ 1` (`nsN_core_eq`);
* `H = ½(πV + Vπ) = (iκ/2)(a†² - a²)`: the **±2-shift** operator
  `(Hx)ₘ = i(w(m-2) x(m-2) - w(m) x(m+2))`, `w(n) = (κ/2)√((n+1)(n+2))`
  (`nsH`, `nsH_core_eq`).

`H` is *not* diagonal, and `[H, N] = -2iκ²(a² + a†²) ≠ 0`.

## What is proved

* `nsH_symmetricOn` — `H` is symmetric on the maximal domain of `N`;
* `nsH_relative_bound` — **the first Faris–Lavine inequality**
  `‖Hx‖² ≤ ½‖Nx‖² + 2κ²‖x‖²`;
* `nsH_commForm_bound` — **the second Faris–Lavine inequality**
  `|⟪x, i[H,N]x⟫| ≤ (2κ + 4κ²) ⟪x, Nx⟫`, proved exactly by the mechanism of the
  theorem: the commutator is the cross term `∝ κ² (a² + a†²)`, and
  `2ab ≤ a² + b²` dominates it by `π² + V² + I = N`;
* `commForm_ne_zero_of_pos` — the commutator form is genuinely non-zero, so the
  bound is not vacuous;
* `nsH_essentiallySelfAdjointOn_core` — consequently, by the Faris–Lavine theorem
  of `BookProof.ChapterFarisLavine` together with the Ikebe–Kato input of
  `BookProof.ChapterNavierStokesIkebeKato`, **the Navier–Stokes fiber Hamiltonian
  is essentially self-adjoint on the finite-mode core**, with no hypothesis left.

Nothing here claims global regularity for the Navier–Stokes equation.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace HermiteFarisLavine

open LpNat FarisLavine IkebeKato

/-! ## Shifting a sequence by two -/



















/-! ## The symbol and the amplitudes of the Hermite representation -/



/-- The off-diagonal amplitude of the Navier–Stokes fiber Hamiltonian
`H = ½(πV + Vπ) = (iκ/2)(a†² - a²)` in the Hermite basis: `H eₙ` has the
component `i w(n)` on `eₙ₊₂` and `-i w(n-2)` on `eₙ₋₂`. -/
noncomputable def amp (κ : ℝ) (n : ℕ) : ℝ := (κ / 2) * Real.sqrt ((n + 1) * (n + 2))

variable {κ : ℝ}







theorem amp_nonneg (hκ : 0 ≤ κ) (n : ℕ) : 0 ≤ amp κ n := by
  have : (0 : ℝ) ≤ Real.sqrt ((n + 1) * (n + 2)) := Real.sqrt_nonneg _
  simp only [amp]
  positivity







/-! ## The Hamiltonian as a `±2`-shift operator -/









/-! ## Square summability -/



section Domain

variable {x : maxDom (oscSymbol κ)}


















/-! ## The inner products of the Hamiltonian

`⟪Hx, y⟫` splits into the two "hopping" series `A` (a particle moves two levels
up) and `B` (two levels down).  Both are absolutely convergent because
`2ab ≤ a² + b²`, and this is the only place where convergence is used. -/
























/-! ## The first Faris–Lavine inequality: the relative bound -/







/-! ## The second Faris–Lavine inequality: the commutator form -/











/-! ## Essential self-adjointness, with no hypothesis left -/



/-! ## The commutator is genuinely non-zero

The bound `± i[H, N] ≤ c N` is not the trivial statement `[H, N] = 0`: the
momentum and the advection field do not commute, and already the two-level state
`e₀ + e₂` sees the commutator. -/









end Domain

end HermiteFarisLavine

end BookProof.NavierStokesFlow



/-!
# The canonical (ladder) realization of the Lagrangian Navier–Stokes Hamiltonian

The Eulerian strand of the Navier–Stokes thread has a canonical/ladder reading of
its full quadratic symbol (`BookProof.ChapterNavierStokesCanonicalVector`) and a
Hermite realization of the fiber generator
(`BookProof.ChapterNavierStokesHermiteCanonical`).  The Lagrangian (parcel)
strand had essential self-adjointness (`ChapterNavierStokesLagrangianKatoRellich`),
the Hashimoto/SIRK selection, the Fock-of-Fock lifting and the Stone flow, but its
positive second-order part

`T = ½ ∑ᵢ Pᵢ² + ν ∑ᵢ Qᵢ²`

was realized concretely only on the abstract *diagonal* instance `diagKR` of
`ℓ²(ℕ)`, where `Pᵢ` and `Qᵢ` commute.  This module removes that asymmetry: it
realizes the parcel momenta `Pᵢ` and the viscous gradients `Qᵢ` as the genuinely
**non-commuting** canonical pairs of a Hermite basis of the trajectory space
`ℓ²(Fin 3 → ℕ)`, and proves the second-order part is essentially self-adjoint
there.

## The construction

For a viscosity `ν > 0` put `ω = √(2ν)` and, out of the Hermite ladder operators
`a_i`, `a_i†` of `BookProof.NavierStokesFlow.CanonicalVector`,

`Qᵢ = ω^{-1/2} · (a_i + a_i†)/√2`,   `Pᵢ = ω^{1/2} · i(a_i† − a_i)/√2`.

These are the position and momentum of the oscillator of frequency `ω`; the
canonical commutation relations survive the rescaling (`comm_lagP_lagQ`,
`comm_lagP_lagQ_of_ne`), so `Pᵢ` and `Qᵢ` genuinely fail to commute — the point
on which the diagonal instance `diagKR` was silent.

The identity that makes the module work is

`½ Pᵢ² + ν Qᵢ² = (ω/2)(πᵢ² + uᵢ²) = ω (a_i† a_i + ½)`,

which is exactly the choice `ω = √(2ν)` (`lagT_eq_number`).  Summed over the
three parcel directions the Lagrangian second-order part is therefore the
number operator of the trajectory-space Hermite basis, `T = ω(N + 3/2)`, whose
eigenvectors are the Hermite states `e_β` (`lagT_coreState`) — a total family,
so `T` is essentially self-adjoint on the Hermite core (`lagT_esa`), unbounded
(`lagT_not_bounded`).

## What is proved

* `lagQ`, `lagP` — the canonical pairs of the trajectory space, with
  `comm_lagP_lagQ` (`[Pᵢ, Qᵢ] = −i`), `comm_lagP_lagQ_of_ne` and the symmetry
  statements `lagQ_isSymmetricDom`, `lagP_isSymmetricDom` (from the adjoint
  relation `inner_ann_cre` between the ladder operators);
* `lagT_eq_number` — `½ ∑Pᵢ² + ν ∑Qᵢ² = ω (N + 3/2)`, `N = ∑ a_i† a_i`;
* `lagT_coreState`, `lagT_esa`, `lagT_not_bounded` — the Hermite states
  diagonalize it, it is essentially self-adjoint on the Hermite core and it is
  unbounded;
* `lagCanData` — the resulting `LagrangianFullData` on `ℓ²(Fin 3 → ℕ)`: the
  canonical/ladder realization of the transformed Navier–Stokes Hamiltonian,
  with the physical drift `Dᵢ = Pᵢ` and an arbitrary external force;
* `lagCan_secondOrder_eq`, `lagCan_esa` — its second-order part is the operator
  above and the **full** transformed Hamiltonian is essentially self-adjoint on
  the Hermite core, by the Kato–Rellich relative bound of
  `ChapterNavierStokesLagrangianKatoRellich`;
* `lagCan_stone_flow` — hence the canonical Lagrangian Hamiltonian generates a
  complete unitary flow (Stone), bringing the Lagrangian strand to the same
  realization level as the Eulerian one.

## Honest boundary

Unchanged (Contention D5): nothing here claims global regularity of the
*classical* Navier–Stokes PDE.  The trajectory space is the Hermite
(occupation-number) realization `ℓ²(Fin 3 → ℕ)` of the parcel coordinates, in
which `Qᵢ` is the coordinate and `Pᵢ = −i∂/∂Xᵢ` the momentum, exactly as on the
Eulerian side.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace LagrangianCanonical

open LpNat FarisLavine IkebeKato FullEsa LagrangianEsa LagrangianKatoRellich
open CanonicalVector ThreeComponent

/-! ## The adjoint relation between the ladder operators -/

theorem raise_injective (i : Fin 3) : Function.Injective (raise i) := by
  intro β γ h
  have := congrArg (lower i) h
  simpa using this











/-! ## The number operator of the Hermite basis -/









/-! ## The canonical pairs of the trajectory space -/

variable (nu : ℝ)



















/-! ## The second-order part is the number operator -/



/-! ## The canonical Lagrangian data, and its essential self-adjointness -/









/-! ## Diagonalization by the Hermite states -/



















/-! ## Unboundedness, and the complete unitary flow -/







end LagrangianCanonical

end BookProof.NavierStokesFlow



/-!
# Shift Hamiltonians and their Faris–Lavine inequalities

`BookProof.ChapterNavierStokesHermiteFarisLavine` proves the two Faris–Lavine
inequalities for the Navier–Stokes fiber Hamiltonian of a *single* degree of
freedom, where the Hamiltonian is the `±2`-shift of `ℓ²(ℕ)`.  The Fock-space
(many-mode) Hamiltonian is a **sum** of such shift operators, one for each field
mode, acting on the occupation-number space `ℓ²(ℕᵈ)`.  This module isolates the
one-mode analysis in a form that does not mention `ℕ` at all, so that it can be
applied to each mode of the many-mode problem separately.

## The abstract data

A `ShiftData ι` consists of

* a symbol `σ ≥ 1` on the index set `ι` (the comparison operator `N` is
  multiplication by `σ`),
* an injective *shift* `s : ι → ι` (for the mode `i` of the Fock space,
  `s α = α + 2eᵢ`: the creation of two quanta in the mode `i`),
* an amplitude `w ≥ 0` with `w β ≤ w (s β)`, dominated by the symbol,
  `w β ≤ ¼ σ β + K`,
* a constant symbol increment along the shift, `σ (s β) = σ β + Δ`.

The associated Hamiltonian is the antisymmetric hopping operator

`(H x)_β = i ( w(s⁻¹β) x_{s⁻¹β} − w(β) x_{s β} )`,

which for the Navier–Stokes fiber is `½(π V + V π) = (iκ/2)(a†² − a²)`.

## What is proved

* `shiftH_symmetricOn` — `H` is symmetric on the maximal domain of `N`;
* `shiftH_relative_bound` — `‖H x‖² ≤ ½‖N x‖² + 8K²‖x‖²`;
* `shiftH_commForm_bound` — `|⟪x, i[H, N]x⟫| ≤ 2Δ(¼ + K) ⟪x, N x⟫`;
* `hasSum_commForm` — the commutator form is the hopping series
  `2Δ ∑ w(β) Re(x̄_β x_{sβ})`, in general non-zero.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace ShiftHamiltonian

open LpNat FarisLavine IkebeKato

/-- The data of an abstract shift Hamiltonian: a comparison symbol `σ ≥ 1`, an
injective shift `s`, and a hopping amplitude `w` dominated by the symbol. -/
structure ShiftData (ι : Type*) where
  /-- The symbol of the comparison operator `N`. -/
  sym : ι → ℝ
  /-- The shift: the hopping `β ↦ s β`. -/
  shift : ι → ι
  /-- The hopping amplitude. -/
  amp : ι → ℝ
  /-- The additive constant in the domination of the amplitude by the symbol. -/
  K : ℝ
  /-- The increment of the symbol along the shift. -/
  step : ℝ
  shift_injective : Function.Injective shift
  amp_nonneg : ∀ β, 0 ≤ amp β
  amp_mono : ∀ β, amp β ≤ amp (shift β)
  K_nonneg : 0 ≤ K
  step_nonneg : 0 ≤ step
  sym_ge_one : ∀ β, 1 ≤ sym β
  amp_le : ∀ β, amp β ≤ (1 / 4) * sym β + K
  sym_step : ∀ β, sym (shift β) = sym β + step

variable {ι : Type*} (S : ShiftData ι)

namespace ShiftData





/-! ## Transporting a sequence along the shift -/

/-- `S.hop g` is `g` transported along the shift: it is `g α` at `s α` and `0`
off the range of the shift. -/
noncomputable def hop {M : Type*} [Zero M] (g : ι → M) : ι → M :=
  Function.extend S.shift g 0

























/-! ## The Hamiltonian -/









/-! ## Square summability -/



















/-! ## The inner products of the Hamiltonian

`⟪Hx, y⟫` splits into the two hopping series `A` (a hop along the shift) and `B`
(a hop against it).  Both converge absolutely because `2ab ≤ a² + b²`. -/























/-! ## The first Faris–Lavine inequality: the relative bound -/





/-! ## The second Faris–Lavine inequality: the commutator form -/













end ShiftData

end ShiftHamiltonian

end BookProof.NavierStokesFlow



/-!
# The three coupled velocity components

The Navier–Stokes fiber analysis carried out in
`BookProof.ChapterNavierStokesAffineFiberEsa` and
`BookProof.ChapterNavierStokesAffineBlockEsa` carries **one** velocity
component: the fiber Hilbert space is `ℓ²(ℕ)`, the Hermite representation of a
single degree of freedom `u`, and the fiber field is the affine
`V(u) = κ u + c`.  The recorded boundary was the coupling of the three velocity
components.

This module removes it.  At one fiber the velocity is now the vector
`u = (u₁, u₂, u₃)`, the Hermite basis is indexed by `Vel = Fin 3 → ℕ`, the fiber
fields are the affine

`V_i(u) = ∑_k A_{ik} u_k + c_i`,

with `A` an **arbitrary real** `3 × 3` matrix (the negative velocity gradient at
the fiber, with no symmetry, positivity or sign assumption) and `c` an arbitrary
real vector, and the fiber Hamiltonian is

`H = ∑_i ½(π_i V_i + V_i π_i)`.

## The Hermite matrix of `H`

Writing `u_i = (a_i + a_i†)/√2` and `π_i = i(a_i† − a_i)/√2`, the terms are

* `A_{ii} ½(π_i u_i + u_i π_i) = (i A_{ii}/2)(a_i†² − a_i²)` — a `±2`-hopping in
  the coordinate `i`, amplitude `(A_{ii}/2)√((β_i+1)(β_i+2))`;
* for `i ≠ k`, `A_{ik} π_i u_k + A_{ki} π_k u_i = i S_{ik}(a_i†a_k† − a_i a_k)
  + i D_{ik}(a_i† a_k − a_i a_k†)` with `S = (A_{ik}+A_{ki})/2` and
  `D = (A_{ik}−A_{ki})/2` — a **double-raising** hopping `β ↦ β + e_i + e_k` of
  amplitude `S√((β_i+1)(β_k+1))` (the strain part) and a **number-conserving**
  hopping `β ↦ β + e_i − e_k` of amplitude `D√((β_i+1)β_k)` (the vorticity
  part);
* `c_i π_i = (i c_i/√2)(a_i† − a_i)` — a `±1`-hopping, amplitude
  `(c_i/√2)√(β_i+1)`.

The vorticity hopping has an amplitude that is *not* monotone along its shift,
and the strain rates and constants have arbitrary signs, so neither
`ShiftHamiltonian.ShiftData` nor its two-shift version applies.  The instrument
used here is `SignedShift.listH_essentiallySelfAdjointOn_core`, which needs
neither positivity nor monotonicity.

## What is proved

* `velH` — the coupled three-component fiber Hamiltonian on the maximal domain
  of the comparison symbol `N = μ(2|β| + 3) + 1` in `ℓ²(Vel)`;
* `velH_symmetricOn` — it is symmetric;
* `velH_essentiallySelfAdjointOn_core` — **the headline**: it is essentially
  self-adjoint on the finite-mode core of `ℓ²(Vel)`, for every real matrix `A`
  and every real vector `c`;
* `velH_coord_pair`, `velH_coord_rot`, `velH_coord_shear`, `velH_coord_diag` —
  the matrix entries: the coupling between distinct components really is
  present;
* `velH_not_bounded` — the operator is unbounded.

## Honest boundary

The setting is the abstract sequence space `ℓ²(Vel)` with the operator given by
its matrix in the Hermite basis of the fiber.  The canonical reading of that
matrix — the ladder pairs, the canonical commutation relations, and the identity
`∑_i ½(π_i V_i + V_i π_i) = velH A c` — is supplied by
`BookProof.ChapterNavierStokesCanonicalVector`; the unitary transport of that
picture to `L²(du₁du₂du₃)` is not built here, and nothing here claims global
regularity for the classical Navier–Stokes equation.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace ThreeComponent

open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift

/-! ## The Hermite multi-index of the three components -/

/-- The Hermite multi-index of the three velocity components at one fiber. -/
abbrev Vel := Fin 3 → ℕ

/-- The total Hermite level `|β| = β₁ + β₂ + β₃`. -/
def total (β : Vel) : ℕ := ∑ i, β i

/-- Creation of one quantum in the component `i`. -/
def raise (i : Fin 3) (β : Vel) : Vel := Function.update β i (β i + 1)

/-- Annihilation of one quantum in the component `i` (truncated at `0`). -/
def lower (i : Fin 3) (β : Vel) : Vel := Function.update β i (β i - 1)



@[simp] theorem raise_self (i : Fin 3) (β : Vel) : raise i β i = β i + 1 := by
  simp [raise]

theorem raise_of_ne {i j : Fin 3} (h : j ≠ i) (β : Vel) : raise i β j = β j := by
  simp [raise, Function.update_of_ne h]

@[simp] theorem lower_self (i : Fin 3) (β : Vel) : lower i β i = β i - 1 := by
  simp [lower]

theorem lower_of_ne {i j : Fin 3} (h : j ≠ i) (β : Vel) : lower i β j = β j := by
  simp [lower, Function.update_of_ne h]



theorem raise_injective (i : Fin 3) : Function.Injective (raise i) := by
  intro β γ h
  funext j
  by_cases hj : j = i
  · subst hj
    have := congrFun h j
    simp only [raise_self] at this
    omega
  · have := congrFun h j
    rwa [raise_of_ne hj, raise_of_ne hj] at this















/-! ## The four shifts -/



























/-! ## The comparison symbol and the coefficient bound -/





variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)













/-! ## The amplitudes -/













/-! ## The amplitudes are dominated by the comparison symbol -/















/-! ## The twenty-four hopping terms -/











/-! ## The coupled three-component fiber Hamiltonian -/







/-! ## Matrix entries: the coupling really is present -/
































/-! ## Unboundedness -/

















end ThreeComponent

end BookProof.NavierStokesFlow



/-!
# PA-Free Completion: The Riesz–Fischer Framework

We formalize the Riesz–Fischer characterization for the finitely-supported
core and its completion. The completion adds exactly the limit points
needed for Hilbert space completeness without introducing new "pathological"
vectors.

This is the mathematical foundation for the Solovay–Hilbert decidability
architecture: the completion of the finitely-supported core does not
leak PA / is a conservative extension.

**Update (August 2026).**  The Riesz–Fischer statement of this file used to be a
`True` placeholder.  It is now a genuine theorem: the analytic content lives in
`BookProof/ChapterRieszFischer.lean`, and this file records the identification of
the dense core `ℕ →₀ ℝ` with the finitely-supported vectors of `ℓ²(ℕ)`
(`range_ofCore`) together with the completeness / density / properness package
(`riesz_fischer`, `denseCore_dense`, `denseCore_proper`).
-/

open Set
open Filter
open BookProof.ChapterRieszFischer

/-- The dense core: finitely-supported vectors on ℕ.
    These represent the "definable" or "computable" vectors
    in the Riesz–Fischer framework. -/
abbrev DenseCore := ℕ →₀ ℝ





/-- The canonical embedding of the dense core into its completion `ℓ²(ℕ)`:
a finitely-supported sequence is the (finite) sum of its coordinate atoms. -/
noncomputable def ofCore (v : DenseCore) : Ell2 :=
  ∑ i ∈ v.support, lp.single 2 i (v i)



/-!
# Chapter "On the physical parity transformation and antiparticles" — `SU(2)_L` has
trivial outer automorphism (complex conjugation is inner)

This file continues the finite algebraic core of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7522, §"Majorana spinors in
the Standard Model").  The chapter states:

  *"The outer automorphism group of `SU(3)` or `U(1)_Y` is `Z₂`, while the outer
  automorphism group of `SU(2)_L` is the trivial group."*

The relevant automorphism is **complex conjugation** `g ↦ g*` (which sends a
representation to its complex-conjugate representation).  For `SU(3)` this is a
*nontrivial* outer automorphism: entrywise conjugation of the Gell-Mann generators
negates `λ², λ⁵, λ⁷` (`ChapterParity.gellMann_conj`), and no fixed similarity undoes it.

For `SU(2)`, however, the fundamental representation is **pseudoreal**: complex conjugation
is realized by conjugation with the fixed matrix `σ₂`.  On the Lie-algebra generators
`i σ_j` this is the identity

  `conj(i σ_j) = σ₂ (i σ_j) σ₂⁻¹`   (with `σ₂⁻¹ = σ₂`),

so the complex-conjugate representation is *unitarily equivalent* to the original — i.e.
complex conjugation is an **inner** automorphism, and the outer automorphism group of
`SU(2)_L` is trivial.

## Contents

* `pauliV` — the three Pauli matrices `σ₁, σ₂, σ₃` (with `σ₂ = ChapterParity.pauli2`).
* `pauliV_pseudoreal` : `σ₂ σ_j σ₂ = -(σ_j)*` — the pseudoreality intertwiner.
* `su2gen` — the `su(2)` generators `i σ_j`.
* `su2_conj_inner` : `conj(i σ_j) = σ₂ (i σ_j) σ₂` — complex conjugation of the `su(2)`
  generators is inner (conjugation by the fixed `σ₂`, an involution `σ₂² = 1`), so
  `SU(2)_L` has trivial outer automorphism.

The surrounding physical modelling (the Standard-Model gauge structure) is left as prose.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterParitySU2

open BookProof.ChapterParity

/-- The Pauli matrix `σ₁`. -/
noncomputable def pauli1 : Matrix (Fin 2) (Fin 2) ℂ := !![0, 1; 1, 0]

/-- The Pauli matrix `σ₃`. -/
noncomputable def pauli3 : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, -1]

/-- The three Pauli matrices `σ₁, σ₂, σ₃`, indexed `0, 1, 2` (with `σ₂ =
`ChapterParity.pauli2`). -/
noncomputable def pauliV : Fin 3 → Matrix (Fin 2) (Fin 2) ℂ
  | 0 => pauli1
  | 1 => pauli2
  | 2 => pauli3







end BookProof.ChapterParitySU2



/-!
# Chapter "On the physical parity transformation and antiparticles" — the electroweak
`SU(2)_L` field strength via the trace projection

This file continues the finite algebraic core of the `book.tex` chapter *"On the physical
parity transformation and antiparticles"* (`book.tex` line ~7522, §"Majorana spinors in
the Standard Model").  The chapter records the electroweak field-strength tensors as
*trace projections* of the covariant-derivative commutator onto the Pauli generators:

  `W_{μν}^j = -\frac{i}{g}\,\mathrm{tr}([D_μ, D_ν]\,τ^j)
            = ∂_μ W_ν^j - ∂_ν W_μ^j - g\,ε^{jkl} W_μ^k W_ν^l`,
  `B_{μν}   = -\frac{i}{g'}\,\mathrm{tr}([D_μ, D_ν]\,σ_3) = ∂_μ B_ν - ∂_ν B_μ`,

with `D_μ = ∂_μ + i g W_μ^j τ_j/2 + …`.  The self-contained algebraic content — with the
partial derivatives abstracted as free "curvature" inputs — is a computation with the three
Pauli matrices `σ₁, σ₂, σ₃` (`ChapterParitySU2.pauliV`) and the totally antisymmetric
`ε^{jkl}` (`SU(2) ≅ su(2)` structure constants).  The physical modelling (the actual
space-time derivatives, the gauge fields as operator-valued distributions, the Lagrangian)
is left as prose.

Deliverables:

* `pauli_trace_orthonormal` : `tr(σ_a σ_b) = 2 δ_{ab}` — the generators are trace-orthogonal.
* `pauli_triple_trace` : `tr(σ_a σ_b σ_c) = 2 i ε_{abc}` — the closed form for the trace of
  a triple product (the source of the structure constants).
* `pauli_commutator` : `[σ_k, σ_l] = 2 i ∑_m ε_{klm} σ_m` — the `su(2)` commutation relations.
* `pauli_commutator_trace` : `tr([σ_k, σ_l] σ_j) = 4 i ε_{klj}`.
* `connection_comm_trace` : the trace projection of the quadratic (commutator) part of the
  curvature reproduces `i ∑_{k,l} ε_{klj} W_μ^k W_ν^l`.
* **`electroweak_fieldStrength`** (headline) : the full non-abelian trace-projection formula
  `-\frac{i}{g}\,\mathrm{tr}(F_{μν}\,σ^j) = G_j - g\,ε^{jkl} W_μ^k W_ν^l`, where `G_j` is the
  linear (curl) part `∂_μ W_ν^j - ∂_ν W_μ^j` and
  `F_{μν} = i g\,(∑_j G_j\,σ_j/2) + (i g)²\,[A_μ, A_ν]` is the `su(2)` curvature written
  from the covariant-derivative commutator `[D_μ, D_ν]`.
* **`abelian_fieldStrength`** (companion) : for a single abelian (`U(1)`) field the quadratic
  term drops out and the trace projection returns the pure curl `-\frac{i}{g}\,
  \mathrm{tr}(F_{μν}\,σ_3) = G` (`B_{μν} = ∂_μ B_ν - ∂_ν B_μ`).

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix

namespace BookProof.ChapterElectroweakFieldStrength

open BookProof.ChapterParity BookProof.ChapterParitySU2



















/-- The book's trace projection `-\frac{i}{g}\,\mathrm{tr}(F σ^j)` extracting the `j`-th
field-strength component from an `su(2)`-valued curvature `F`. -/
noncomputable def proj (g : ℂ) (F : Matrix (Fin 2) (Fin 2) ℂ) (j : Fin 3) : ℂ :=
  (-Complex.I / g) * (F * pauliV j).trace











end BookProof.ChapterElectroweakFieldStrength



/-!
# The general quadratic Hamiltonian of a boson field with infinitely many modes

`BookProof.ChapterFullQuadraticEsa` proves that *every* real quadratic-plus-linear
Hamiltonian in **finitely many** degrees of freedom is essentially self-adjoint on the
Gauss–polynomial core.  This module removes the finiteness of the mode set: the modes are
indexed by an arbitrary type `ι`, the Hilbert space is the boson Fock space
`ℓ²(ι →₀ ℕ)` of occupation-number configurations, and the Hamiltonian is the
second-quantized quadratic expression

`H = ∑ᵢ ωᵢ aᵢ†aᵢ + ∑ₖ (gₖ a^{†Pₖ}a^{Qₖ} + conj(gₖ) a^{†Qₖ}a^{Pₖ})`,

where each interaction term `a^{†P}a^{Q}` is a product of `|P| + |Q| ≤ 2` creation and
annihilation operators — pair creation `aᵢ†aⱼ†`, pair annihilation `aⱼaᵢ`, mode exchange
`aᵢ†aⱼ`, and the linear sources `aᵢ†`, `aᵢ`.  The free dispersion `ω` is an arbitrary
non-negative function of the mode — it need not be bounded — and the interaction is an
arbitrary family, subject only to the weighted absolute summability

`∑ₖ ‖gₖ‖ (ω(Pₖ) + ω(Qₖ) + 2) < ∞`.

The route is Faris–Lavine (Nelson's commutator theorem) with the comparison operator
`N = ∑ᵢ ωᵢ aᵢ†aᵢ + 𝒩 + 1`, `𝒩` the total number operator: each elementary hop is
relatively bounded by `N` and has commutator form dominated by `N`, with constants which
are summable exactly under the hypothesis above; the series instrument
`BookProof.OperatorSeries.essentiallySelfAdjointOn_finiteModes_of_series` then applies.

## What is proved

* `deg`, `wsum`, `sig` — the total occupation number `|α|`, the free energy
  `ω(α) = ∑ᵢ ωᵢ αᵢ` and the comparison symbol `σ(α) = ω(α) + |α| + 1`.
* `fall`, `amp`, `tgt` — the falling factorial of a multi-index, the ladder amplitude of
  the monomial `a^{†P}a^{Q}` and the configuration it hops to; `amp_symm` is the
  self-adjointness of the amplitude under `(P, Q) ↦ (Q, P)`.
* `hopOp` — the elementary monomial as an operator on the maximal domain of `σ`, with
  `hopOp_norm_le` (relative bound) and `hopOp_pairing` (the adjoint relation
  `⟪a^{†P}a^{Q}x, y⟫ = ⟪x, a^{†Q}a^{P}y⟫`).
* `pairOp` — the Hermitian combination `g a^{†P}a^{Q} + conj(g) a^{†Q}a^{P}`, with its
  symmetry, its relative bound and its commutator-form bound.
* `freeOp` — the free Hamiltonian `∑ᵢ ωᵢ aᵢ†aᵢ`, symmetric, dominated by `N` and
  commuting with it.
* `fockH` and `fockH_essentiallySelfAdjointOn_core` — **the headline**: the full
  Hamiltonian is essentially self-adjoint on the finite-particle core of the Fock space.
* `bogoliubov_essentiallySelfAdjointOn_core` — the pair-creation (Bogoliubov)
  specialization.

Everything is `sorry`-free and `axiom`-free.
-/

open scoped ENNReal

namespace BookProof.FockQuadratic

open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat

noncomputable section

variable {ι : Type*}

/-! ## 1. Occupation-number configurations -/

/-- An occupation-number configuration: finitely many modes excited. -/
abbrev Idx (ι : Type*) := ι →₀ ℕ

/-- The total occupation number `|α| = ∑ᵢ αᵢ`. -/
def deg (a : Idx ι) : ℕ := a.sum fun _ n => n









/-- The free energy `ω(α) = ∑ᵢ ωᵢ αᵢ` of a configuration. -/
def wsum (ω : ι → ℝ) (a : Idx ι) : ℝ := a.sum fun i n => ω i * n







/-- **The comparison symbol** `σ(α) = ω(α) + |α| + 1`: the free energy plus the total
occupation number plus one. -/
def sig (ω : ι → ℝ) (a : Idx ι) : ℝ := wsum ω a + deg a + 1







/-! ## 2. Falling factorials and the ladder amplitude -/

/-- The falling factorial `n(n-1)⋯(n-p+1)`, truncated to `0` when `n < p`. -/
def fallNat (n p : ℕ) : ℕ := ∏ k ∈ Finset.range p, (n - k)





/-- The falling factorial of a multi-index: `α!/(α-P)!`. -/
def fall (a P : Idx ι) : ℕ := ∏ i ∈ P.support, fallNat (a i) (P i)





/-- The configuration reached from `α` by the monomial `a^{†P}a^{Q}`… as read on
coefficients: the coefficient of `α` in the image involves the coefficient of
`tgt P Q α = α - P + Q`. -/
def tgt (P Q a : Idx ι) : Idx ι := a - P + Q









/-- **The ladder amplitude** of the monomial `a^{†P}a^{Q}`. -/
def amp (P Q a : Idx ι) : ℝ := Real.sqrt (fall a P) * Real.sqrt (fall (tgt P Q a) Q)

theorem amp_nonneg (P Q a : Idx ι) : 0 ≤ amp P Q a :=
  mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)













/-! ## 3. Reindexing along a hop -/











/-! ## 4. The elementary monomial as an operator -/

variable {ω : ι → ℝ}

















/-! ### The pairing symbol -/









/-! ## 5. The Hermitian interaction term -/










/-! ## 6. The free Hamiltonian -/











/-! ## 7. The Hamiltonian and its essential self-adjointness -/

variable {κ : Type*}






/-! ## 8. The Bogoliubov specialization -/

















end

end BookProof.FockQuadratic



/-!
# The half-line kinetic operator is **not** essentially self-adjoint

Plan item **QG-2 / 29f Case B** of `CONSOLIDATED_PLAN.md` records that the
densitized conformal direction of the gauge-fixed theory lives on the half line
`y ∈ (0, ∞)` (`y = √e`, `e` the tetrad determinant, `e = 0` being the
degenerate-tetrad endpoint) and carries a **wrong-sign** kinetic term, and that
the densitized d'Alembertian is therefore expected to fail essential
self-adjointness — the limit-circle phenomenon at the endpoint.  Its companion
module `BookProof/ChapterConformalSignFlip.lean` proves the sign bookkeeping
(essential self-adjointness is invariant under `H ↦ −H`) but leaves the
analytic statement itself unformalized.

This module supplies that analytic statement, in the cleanest instance: the
**free** kinetic operator on the half line.

* `testSpace` — the smooth functions with compact support contained in the open
  half line `(0, ∞)`, `hlCore` their image in `L²((0,∞))` and `hlKin` the
  operator `−d²/dy²` on that core (`hlKin_apply`), which is symmetric
  (`hlKin_symmetricOn`);
* `deficiencyFun y = exp(−λy)`, `λ = (√2/2)(1 − i)`, satisfies `λ² = −i`, is
  square integrable on `(0, ∞)` and is **not** the zero element of `L²`
  (`deficiencyVec_ne_zero`);
* `hlKin_deficiency_identity` — it satisfies the adjoint deficiency identity
  `⟪−v'', w⟫ = i⟪v, w⟫` for every `v` in the core, by two integrations by parts
  (the boundary terms vanish because the test functions are supported away from
  the endpoint);
* **`hlKin_not_deficiencyTrivialAt_I`**, **`hlKin_not_essentiallySelfAdjointOn`**
  — hence the deficiency space at `i` is non-trivial and the half-line kinetic
  operator is not essentially self-adjoint on this core;
* **`hlKin_neg_not_essentiallySelfAdjointOn`** — and, by the sign-flip theorem
  of `ChapterConformalSignFlip`, neither is the **wrong-sign** kinetic operator
  `+d²/dy²`, which is the one the densitized conformal direction carries.  This
  is Case B's conclusion for the free densitized kinetic: no choice of sign
  convention rescues it, and the failure is caused by the endpoint, not by any
  potential.
* `hlCore_ne_bot` — and the core is not the zero subspace (an explicit smooth
  bump supported in `(1, 3)` lies in it), so none of this is vacuous.

## Honest boundary

What is proved is non-essential-self-adjointness of the *free* kinetic operator
on the compactly-supported core of the open half line — the endpoint
(limit-circle) mechanism in its purest form.  Nothing here treats a potential
`V(y)` (the limit-circle analysis of the unbounded-below flipped potential
remains unformalized), and nothing here is a statement about the full
multi-dimensional densitized operator.  Failure of essential self-adjointness
on a core means the symmetric operator has more than one self-adjoint
extension, not that no self-adjoint extension exists.

Everything in this module is `sorry`-free and `axiom`-free.
-/

namespace BookProof.HalfLineLimitCircle

open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)





/-! ## The test-function core -/







































/-! ## Integration by parts on the half line -/





/-! ## The deficiency vector -/

/-- `λ = (√2/2)(1 − i)`, a square root of `−i` with positive real part. -/
def lam : ℂ := (Real.sqrt 2 / 2 : ℝ) * (1 - Complex.I)



























/-! ## The inner products, and the failure of essential self-adjointness -/













/-! ## The core is non-trivial

The statements above would be vacuous if the core were the zero subspace, so we
exhibit an explicit element: a smooth bump centred at `2` with support the
interval `(1, 3)`, comfortably inside the open half line.
-/















end

end BookProof.HalfLineLimitCircle



/-!
# The product Hermite basis of `L²(ℝᵈ)` and its ladder relations

`BookProof.ChapterHermiteProductCore` builds the Gauss–polynomial core
`polyGaussCore` of `L²(ℝᵈ)` — the polynomials times `e^{-‖x‖²/4}` — proves it dense, and
shows it is the span of the *product Hermite functions*
`ψ_α(x) = ∏ᵢ He_{αᵢ}(xᵢ) · e^{-‖x‖²/4}` (`polyGaussCore_eq_hermiteSpan`).  What it does
*not* do is make that family an orthonormal basis, or relate it to the ladder (creation /
annihilation) operators.  Both are supplied here; they are what the differential
realization of the Navier–Stokes quadratic symbol
(`BookProof.ChapterNavierStokesDifferentialL2`) needs.

## Contents

* `eval_hermiteFactor`, `pgFun_hermiteMv` — the product Hermite function is the product of
  the one-dimensional Hermite functions of `BookProof.ChapterHermiteFunctions`, coordinate
  by coordinate;
* `inner_pgLp_hermiteMv` — the `L²` inner product of two of them is the product of the
  one-dimensional Hermite inner products (Fubini);
* `hermiteMvNorm`, `hermiteMvLp`, `orthonormal_hermiteMvLp`, `span_hermiteMvLp`,
  `hermiteMvBasis` — the **orthonormal (Hilbert) basis** `ψ_α / ‖ψ_α‖` of `L²(ℝᵈ)` indexed
  by the multi-indices `α : Fin d →₀ ℕ`, whose span is exactly the Gauss–polynomial core;
* `pderiv_hermiteMv` — `∂ᵢ He_α = αᵢ He_{α−eᵢ}` for the product Hermite *polynomials*;
* `annPoly`, `crePoly` and `annPoly_hermiteMvLp`, `crePoly_hermiteMvLp` — the polynomial
  incarnations of the ladder operators
  `aᵢ = xᵢ/2 + ∂ᵢ`, `aᵢ† = xᵢ/2 − ∂ᵢ` acting on the Gauss-weighted functions, and their
  action `aᵢψ_α = √αᵢ ψ_{α−eᵢ}`, `aᵢ†ψ_α = √(αᵢ+1) ψ_{α+eᵢ}` on the orthonormal basis.

The Gaussian factor is what turns the *polynomial* operators `p ↦ ∂ᵢp` and
`p ↦ xᵢp − ∂ᵢp` into the *function* operators `f ↦ (xᵢ/2)f + f'` and `f ↦ (xᵢ/2)f − f'`:
`∂ᵢ(p·e^{-‖x‖²/4}) = (∂ᵢp − (xᵢ/2)p)·e^{-‖x‖²/4}`.  The analytic side of that identity is
proved in `BookProof.ChapterNavierStokesDifferentialL2`; here everything is algebraic.
-/

namespace BookProof.HermiteProductBasis

open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

/-! ## The product Hermite functions, coordinate by coordinate -/













/-! ## The orthonormal basis -/

/-- The `L²` norm of the product Hermite function `ψ_α`. -/
def hermiteMvNorm (a : Fin d →₀ ℕ) : ℝ := ∏ i, hermiteNorm (a i)





/-- **The normalized product Hermite function** `ψ_α / ‖ψ_α‖`. -/
def hermiteMvLp (a : Fin d →₀ ℕ) : L2d d := ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv a)















/-! ## The derivative of a product Hermite polynomial -/











/-! ## The ladder operators, at the level of polynomials -/

/-- The polynomial incarnation of the annihilation operator: multiplying by the Gaussian,
`p ↦ ∂ᵢp` is the function operator `f ↦ (xᵢ/2)f + ∂ᵢf`. -/
def annPoly (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun p := pderiv i p
  map_add' p q := by simp
  map_smul' c p := by simp

/-- The polynomial incarnation of the creation operator: multiplying by the Gaussian,
`p ↦ xᵢp − ∂ᵢp` is the function operator `f ↦ (xᵢ/2)f − ∂ᵢf`. -/
def crePoly (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun p := X i * p - pderiv i p
  map_add' p q := by simp [mul_add]; ring
  map_smul' c p := by simp [smul_sub]







/-! ### The normalizing constants -/







/-! ### The ladder action on the orthonormal basis -/

theorem pgMap_apply (p : MvPolynomial (Fin d) ℂ) : pgMap p = pgLp p := rfl





end

end BookProof.HermiteProductBasis



/-!
# Essential self-adjointness from a complete flow, on a genuinely dense domain

Companion to `BookProof.ChapterNavierStokesFlow` and
`BookProof.ChapterNavierStokesCauchy`.

Those modules prove that the truncated Navier–Stokes Hamiltonian is Hermitian,
that its flow `U(t) = e^{i t H_N}` is a one-parameter unitary group defined for
every real time, and that the associated Cauchy problem has exactly one global
solution.  Essential self-adjointness (`HasZeroDeficiencyOn`) was, however, only
established there for the **full** domain `D = ⊤`, where symmetry alone suffices.

The analytic content of the notion lives on a *proper* dense domain, and this
module supplies it:

* `eq_zero_of_hasDerivAt_smul_of_bounded` — a bounded solution of `g' = ± g` on
  the real line vanishes at the origin (the elementary ODE step);
* `hasZeroDeficiencyOn_of_completeUnitaryFlow` — **the headline.** If a symmetric
  operator `H` on a dense domain `D` generates a norm-preserving flow `U` which
  is defined for *every* real time and leaves `D` invariant, then the deficiency
  spaces of `H∗` vanish, i.e. `H` is essentially self-adjoint.  This is the
  precise form of the statement that the plan's scoping section appeals to when
  it says that *the deficiency argument requires the flow to be complete*
  (Nelson's criterion): completeness of the flow is exactly the hypothesis, and
  a finite-time blow-up destroys it;
* `nsHamiltonian_hasZeroDeficiencyOn_of_flow` — the truncated Navier–Stokes
  generator, re-derived along that route from the completeness of its own flow
  rather than from finite-dimensional symmetry;
* `hasZeroDeficiencyOn_of_bounded_symmetric` — a bounded symmetric operator is
  essentially self-adjoint on **every** dense invariant domain, and
  `continuityHamiltonian_hasZeroDeficiencyOn_finiteModes`, its application to the
  infinite-dimensional `ℓ²(ℤ)` layer of
  `BookProof.ChapterContinuityUnitaryInfinite` on the proper dense domain of
  finitely supported modes.  This is the first instance in the development of
  vanishing adjoint deficiency on a domain that is *not* the whole space, so the
  predicate `HasZeroDeficiencyOn` is not vacuous there.

## Scope

Unchanged: nothing here is a statement about the continuum Navier–Stokes
operator.  The flow criterion is proved in full generality, but its hypotheses
(a *complete* norm-preserving flow leaving the domain invariant) are exactly
what is not known for the untruncated Navier–Stokes generator — that is the
research target recorded in `BookProof.ChapterNavierStokesFlow`.
-/

open scoped Matrix

namespace BookProof.NavierStokesFlow

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]















end Abstract

/-! ## Finitely supported modes of an `ℓ²` space

The *finite-particle domain* of an `ℓ²` space: the states exciting only finitely
many modes.  It is dense (every `ℓ²` state is the limit of its truncations) and,
whenever the index type is infinite, a **proper** subspace — so it is the natural
place to test statements about densely defined operators. -/

section LpFiniteModes

variable {ι : Type*}

/-- The **finitely supported modes** of `ℓ²(ι)`. -/
def lpFiniteModes (ι : Type*) : Submodule ℂ (lp (fun _ : ι => ℂ) 2) where
  carrier := {f : lp (fun _ : ι => ℂ) 2 | (Function.support ((f : ι → ℂ))).Finite}
  add_mem' := by
    intro f g hf hg
    refine Set.Finite.subset (hf.union hg) ?_
    intro k hk
    simp only [Function.mem_support, lp.coeFn_add, Pi.add_apply] at hk
    by_contra hcon
    simp only [Set.mem_union, Function.mem_support, not_or, not_not] at hcon
    exact hk (by rw [hcon.1, hcon.2, add_zero])
  zero_mem' := by
    simp only [Set.mem_setOf_eq, lp.coeFn_zero]
    simp
  smul_mem' := by
    intro c f hf
    refine Set.Finite.subset hf ?_
    intro k hk
    simp only [Function.mem_support, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul] at hk
    exact fun hzero => hk (by rw [hzero, mul_zero])



/-- Each canonical basis state `e_k` has finite support. -/
theorem lpSingle_mem_lpFiniteModes [DecidableEq ι] (k : ι) (c : ℂ) :
    lp.single 2 k c ∈ lpFiniteModes ι := by
  refine Set.Finite.subset (Set.finite_singleton k) ?_
  intro j hj
  simp only [Function.mem_support] at hj
  by_contra hne
  have hjk : j ≠ k := by simpa using hne
  exact hj (by simp [lp.single_apply, Pi.single_eq_of_ne hjk])



end LpFiniteModes

/-! ## An infinite-dimensional instance on a *proper* dense domain

The `ℓ²(ℤ)` layer of `BookProof.ChapterContinuityUnitaryInfinite` carries a
bounded self-adjoint generator, the Weyl-symmetrized continuity Hamiltonian
`H = ½(p v + v p)`.  Its natural *finite-particle* domain — the states with only
finitely many excited lattice modes — is dense but not the whole space, so the
statement `HasZeroDeficiencyOn finiteModes …` is a genuine (non-`⊤`) instance of
essential self-adjointness on a dense domain. -/

section InfiniteLattice

open BookProof.ChapterContinuityUnitaryInfinite



















end InfiniteLattice

/-! ## The truncated Navier–Stokes generator, via its complete flow

The truncation was already known to be essentially self-adjoint by symmetry
(`nsHamiltonian_hasZeroDeficiencyOn`).  Here it is re-derived along the route
that the continuum question would have to follow: from the **completeness** of
its unitary flow. -/

section Truncation

variable {n : ℕ} (d : NSTruncation n)











end Truncation

end BookProof.NavierStokesFlow



/-!
# Chapter "Free field parametrization … Navier–Stokes": the truncated
Navier–Stokes Hamiltonian generates a **complete flow**

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier–Stokes equations"*, §*"Free field parametrization in
Navier–Stokes equations"* (`book.tex` ~4133–4216).  The correspondence between
the book's text and the theorems proved here is:

* ~4151–4173, degrees of freedom, derivatives treated as fields:
  `fieldTaylor`, `field_evaluates_to_value`;
* ~4163–4170, the canonical commutation relations of the modes: `ccr_field`,
  `derivativeField_momentum`, `secondDerivativeField_momentum`;
* ~4184–4189, the Navier–Stokes Hamiltonian: `nsHamiltonian`,
  `nsHamiltonian_hermitian`;
* ~4199, "polynomial of low degree in the fields":
  `nsHamiltonian_isPolynomial` (words of length ≤ 3);
* ~4191–4197, the divergence constraint and its resolution:
  `nsDivergenceConstraint_resolution`, `nsBrst_nilpotent`;
* ~4199–4208, self-adjointness: `nsHamiltonian_hasZeroDeficiency`,
  `nsHamiltonian_hasZeroDeficiencyOn` (**truncation only**) and the conditional
  `ns_esa_of_farisLavine`, `ns_esa_of_farisLavine_dense`;
* ~4210–4216, existence and uniqueness of the solution: `nsFlow_group`,
  `nsFlow_groupOnEvolved`, `nsFlow_noBlowup` (**truncation only**); the
  differential form — the evolution equation `ψ̇ = i H_N ψ` and the unique
  solvability of its Cauchy problem — is in the companion module
  `BookProof.ChapterNavierStokesCauchy`.

## What is proved

Let `H_N` be the Navier–Stokes Hamiltonian **restricted to a finite truncation**
(finitely many field modes `u_k`, `u_{k,j}`, `u_{k,jj}`, each realized by a
Hermitian matrix on a finite-dimensional state space, the modes commuting with
one another as multiplication operators do).  Then

* `nsHamiltonian_hermitian` — `H_Nᴴ = H_N`;
* `nsHamiltonian_isPolynomial` — every term of `H_N` is a word of length at most
  three in the generators `u_k`, `π_i` (the "low degree in the fields"
  hypothesis of `book.tex` ~4199);
* `nsFlow_zero`, `nsFlow_group`, `nsFlow_unitary` — `U(t) = e^{i t H_N}` is a
  one-parameter **unitary group**, defined for *every* real time: the flow of the
  truncation is complete;
* `nsFlow_norm_preserving`, `nsFlow_noBlowup` — the flow preserves the `ℓ²` mass
  and every coefficient of the evolved state stays bounded by the initial mass,
  uniformly in `t`: **no finite-time singularity on the truncation**;
* `nsHamiltonian_hasZeroDeficiency` — the truncated Hamiltonian has vanishing
  deficiency: `H_N ψ = ± i ψ` forces `ψ = 0`.

Alongside the truncation the file records the algebraic core of the surrounding
construction: the derivatives-as-fields Taylor operator (`Part A`), the
Lagrangian change of variables and the volume-preservation constraint
(`Part B`), the BRST ghost charge (`Part E`), and the Faris–Lavine framing of
the continuum essential-self-adjointness question (`Part G`).

## What is *not* claimed

The essential self-adjointness of the **untruncated continuum** operator
`H = ∫ a†(πⁱ(u_j u_{i,j} − ν u_{i,jj}) + h.c.) a`, and with it global existence
and uniqueness for the Navier–Stokes equations, is **not** claimed anywhere in
this file.  The project's own ODE chapter is the standing warning: for `ẋ = x²`
the Hamiltonian `x²p̂ − i x̂` is a polynomial of degree 3 whose classical flow
`x₀/(1 − t x₀)` is incomplete, so a low-degree polynomial Hamiltonian need *not*
be essentially self-adjoint.  Accordingly:

* the degree bound `nsHamiltonian_isPolynomial` is recorded as a **symmetry**
  statement (a well-defined polynomial operator), never as self-adjointness;
* `HasZeroDeficiency` is the deficiency-index-`(0,0)` condition *for the operator
  itself*; on a finite-dimensional space (where the operator is bounded and
  everywhere defined) this is exactly essential self-adjointness, and it is
  proved for the truncation.  For an unbounded operator the deficiency spaces
  are those of the *adjoint*, so the finite statement does not transfer;
* `ns_esa_of_farisLavine` and its densely-defined form
  `ns_esa_of_farisLavine_dense` are **conditional**: the Faris–Lavine commutator
  criterion (Faris–Lavine 1974, Corollary 1.1; Reed–Simon Vol. II Theorem X.28)
  enters as a *named hypothesis*, never as an `axiom`, exactly as Crouzeix's
  inequality does in `BookProof.ChapterH4`.  Verifying its two analytic
  inequalities for the continuum operator is a research target, not a result of
  this file.  The hypothesis is carried in its honest form: symmetry of the
  operator is part of it, since without symmetry the criterion is contradictory
  and the conditional theorem would be vacuous
  (`farisLavine_without_symmetry_forces_trivial`), while with symmetry it is
  satisfiable (`farisLavine_holds_of_everywhereDefined`) — indeed automatic for
  everywhere-defined operators, which is precisely why the analytic content sits
  in the dense-domain predicate `HasZeroDeficiencyOn`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

namespace BookProof.NavierStokesFlow

/-! ## Part A — The field, its derivatives as fields, and the momentum constraint -/

section FieldWithDerivatives

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]





end FieldWithDerivatives











/-! ## Part B — The Lagrangian change of variables and volume preservation -/







/-- The data of the **Lagrangian (parcel) form** of the transformed
Navier–Stokes operator: the parcel momenta `P` (whose squares are the advective
Laplacian `−½Δ_X`), the viscous gradients `Q`, the drift generators `D` with the
external force `f`, the viscosity `nu ≥ 0`, and the 0-order volume-preservation
constraint `C`. -/
structure LagrangianNS (n : ℕ) where
  /-- Parcel momenta: the advection term is `½ ∑ P_i²`. -/
  P : Fin 3 → Matrix (Fin n) (Fin n) ℂ
  /-- Viscous gradient operators: the viscosity term is `nu ∑ Q_i²`. -/
  Q : Fin 3 → Matrix (Fin n) (Fin n) ℂ
  /-- Drift generators of the external force (a first-order term). -/
  D : Fin 3 → Matrix (Fin n) (Fin n) ℂ
  /-- The external force. -/
  f : Fin 3 → ℝ
  /-- The kinematic viscosity. -/
  nu : ℝ
  /-- The 0-order volume-preservation (pressure/ghost) constraint. -/
  C : Matrix (Fin n) (Fin n) ℂ
  P_herm : ∀ i, (P i)ᴴ = P i
  Q_herm : ∀ i, (Q i)ᴴ = Q i
  D_herm : ∀ i, (D i)ᴴ = D i
  C_herm : Cᴴ = C
  nu_nonneg : 0 ≤ nu

namespace LagrangianNS

variable {n : ℕ} (L : LagrangianNS n)

/-- The advective (kinetic) term `−½Δ_X = ½ ∑ P_i²`: a **positive** second-order
operator after the Lagrangian change of variables. -/
noncomputable def kinetic : Matrix (Fin n) (Fin n) ℂ := ((1 : ℝ) / 2) • ∑ i, L.P i * L.P i

/-- The viscous term `nu ∑ Q_i²`, second order. -/
noncomputable def viscous : Matrix (Fin n) (Fin n) ℂ := L.nu • ∑ i, L.Q i * L.Q i

/-- The force drift `∑ f_i D_i`, first order. -/
noncomputable def drift : Matrix (Fin n) (Fin n) ℂ := ∑ i, L.f i • L.D i













end LagrangianNS

/-! ## Part C — The finite truncation is a finite Hermitian matrix -/

/-- The data of a **finite truncation** of the Navier–Stokes system: the fifteen
field modes `u_k` (`k = 0,1,2`), `u_{k,j}` (indices `3 … 11`) and `u_{k,jj}`
(indices `12, 13, 14`) of `book.tex` ~4151–4173, realized as Hermitian matrices
on a finite-dimensional state space, together with the three momenta `π_i` and
the viscosity `nu`.  The field modes commute with one another, as multiplication
operators of a common set of coordinates do. -/
structure NSTruncation (n : ℕ) where
  /-- The fifteen field modes. -/
  u : Fin 15 → Matrix (Fin n) (Fin n) ℂ
  /-- The three momenta `π_i`. -/
  mom : Fin 3 → Matrix (Fin n) (Fin n) ℂ
  /-- The kinematic viscosity. -/
  nu : ℝ
  u_herm : ∀ k, (u k)ᴴ = u k
  mom_herm : ∀ i, (mom i)ᴴ = mom i
  u_comm : ∀ k l, u k * u l = u l * u k



/-- The index of the velocity mode `u_j`. -/
def nsVelIdx (j : Fin 3) : Fin 15 := ⟨j.val, by omega⟩

/-- The index of the first-derivative mode `u_{i,j}`. -/
def nsGradIdx (i j : Fin 3) : Fin 15 := ⟨3 + 3 * i.val + j.val, by omega⟩

/-- The index of the second-derivative mode `u_{i,jj}`. -/
def nsLapIdx (i : Fin 3) : Fin 15 := ⟨12 + i.val, by omega⟩

variable {n : ℕ} (d : NSTruncation n)





























/-! ## Part D — Complete flow on the truncation (no singularities) -/















/-! ## Part E — The divergence constraint and the BRST charge -/













/-! ## Part G — Deficiency, second quantization, and the Faris–Lavine criterion -/

section Deficiency

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]











/-! ### Deficiency of the adjoint on a dense domain

`HasZeroDeficiency` above is the deficiency condition *for the operator itself*,
which is the right notion exactly when the operator is everywhere defined.  The
analytic notion — the one Faris–Lavine is about — asks the deficiency spaces of
the **adjoint** of an operator given on a dense domain `D` to vanish: no `w` may
satisfy `⟪H v, w⟫ = ⟪v, ± i w⟫` for all `v ∈ D` unless `w = 0`.  For `D = ⊤` the
two notions agree (`hasZeroDeficiencyOn_top_of_symmetric`); for a proper dense
domain the second is strictly stronger, and it is *not* claimed here for the
continuum Navier–Stokes operator. -/











end Deficiency



















end BookProof.NavierStokesFlow



/-!
# The **full** (untruncated) Navier–Stokes Hamiltonian and its essential
self-adjointness

`BookProof.ChapterNavierStokesFlow` builds the Navier–Stokes Hamiltonian
`H = ∑_i (π_i A_i + A_i π_i)`, `A_i = ∑_j u_j u_{i,j} − ν u_{i,jj}`, for a
**finite truncation**: the fifteen field modes and the three momenta are
matrices on a finite-dimensional state space.  This module removes the
truncation: the modes and momenta are now (possibly unbounded) operators on a
dense domain `D` of an arbitrary complex inner-product space, and `H` is the
same polynomial expression in them.

## What is proved here

* `NSFullData` — the untruncated data: a dense domain `D`, fifteen symmetric,
  pairwise commuting field modes and three symmetric momenta, all of them
  mapping `D` into `D`, and a viscosity `ν`.  Nothing is finite-dimensional and
  nothing is bounded.
* `NSFullData.hamiltonian_isSymmetricDom` — **the full Hamiltonian is symmetric
  on its domain**, unconditionally.
* `NSFullData.hasZeroDeficiencyOn_of_completeUnitaryFlow` — **essential
  self-adjointness of the full Hamiltonian from a complete unitary flow**
  (Nelson's route), and `NSFullData.hasZeroDeficiencyOn_of_total_eigenvectors`,
  the eigenvector route.
* `NSFullData.hasZeroDeficiencyOn_of_boundedRealization` — if the full
  Hamiltonian is the restriction of a bounded symmetric operator, it is
  essentially self-adjoint on `D`.
* **A genuinely infinite-dimensional, untruncated instance**: on `ℓ²(ℤ)`, with
  all fifteen modes realized as multiplication by bounded real velocity fields
  and the momenta as the lattice (symmetric-difference) momentum, the full
  Navier–Stokes Hamiltonian is essentially self-adjoint on the **proper** dense
  domain of finitely supported modes: `latticeFull_hasZeroDeficiencyOn`.  The
  operator is not the zero operator (`latticeFullHamiltonianCLM_ne_zero`).
* **An unbounded instance**: on `ℓ²(ℕ)`, with all modes and momenta diagonal
  with (possibly unbounded) real symbols, the full Hamiltonian is essentially
  self-adjoint on the finite-mode domain (`diagFull_hasZeroDeficiencyOn`), and
  for a suitable choice of data it is genuinely unbounded
  (`diagFull_not_bounded`).  So essential self-adjointness of the *full*
  Hamiltonian is not a boundedness phenomenon.
* **Sharpness.** `exists_nsFullData_not_hasZeroDeficiencyOn`: there is
  untruncated Navier–Stokes data on `ℓ²(ℕ)` — dense domain, symmetric pairwise
  commuting modes, symmetric momenta, positive viscosity — whose full
  Hamiltonian is **not** essentially self-adjoint.  Hence the structural
  hypotheses alone (Hermitian modes and momenta, degree ≤ 3) can never yield
  essential self-adjointness of the full operator: an analytic input such as
  completeness of the flow is indispensable.  This is the formal counterpart of
  the `ẋ = x²` warning of the ODE chapter.

## Scope

Essential self-adjointness of the *continuum* Navier–Stokes generator, and with
it global existence for Navier–Stokes, is **not** claimed: the positive results
above are unconditional for the realizations described (bounded lattice modes,
diagonal modes), and conditional — on a complete unitary flow, resp. a total
family of eigenvectors — in general, which by
`exists_nsFullData_not_hasZeroDeficiencyOn` is the best possible shape for a
statement about the abstract data.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace FullEsa

/-! ## Symmetry of domain-preserving operators -/

section SymmetricDom

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- Symmetry of an operator that maps the domain `D` into itself. -/
def IsSymmetricDom {D : Submodule ℂ F} (A : D →ₗ[ℂ] D) : Prop :=
  ∀ x y : D, (inner ℂ ((A x : F)) (y : F) : ℂ) = inner ℂ (x : F) ((A y : F))

variable {D : Submodule ℂ F}















end SymmetricDom

/-! ## Transferring vanishing deficiency along an equality of operators -/

section Transfer

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]









end Transfer

/-! ## The untruncated Navier–Stokes data and Hamiltonian -/

section AbstractFull

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The untruncated Navier–Stokes data.**  The fifteen field modes `u_k` and
the three momenta `π_i` of `book.tex` ~4151–4189, now as operators on a *dense
domain* `D` of an arbitrary complex inner-product space — no truncation, no
finite dimension, no boundedness.  The hypotheses are exactly the structural
ones of the truncated `NSTruncation`: the modes and momenta are symmetric on
`D`, they map `D` into itself, and the field modes commute with one another. -/
structure NSFullData (F : Type*) [NormedAddCommGroup F] [InnerProductSpace ℂ F] where
  /-- The dense domain. -/
  D : Submodule ℂ F
  /-- The fifteen field modes. -/
  u : Fin 15 → (D →ₗ[ℂ] D)
  /-- The three momenta. -/
  mom : Fin 3 → (D →ₗ[ℂ] D)
  /-- The kinematic viscosity. -/
  nu : ℝ
  dense : Dense (D : Set F)
  u_symm : ∀ k, IsSymmetricDom (u k)
  mom_symm : ∀ i, IsSymmetricDom (mom i)
  u_comm : ∀ k l, (u k).comp (u l) = (u l).comp (u k)

namespace NSFullData

variable (d : NSFullData F)

/-- The velocity mode `u_j`. -/
def velocity (j : Fin 3) : d.D →ₗ[ℂ] d.D := d.u (nsVelIdx j)

/-- The derivative mode `u_{i,j}`. -/
def gradVelocity (i j : Fin 3) : d.D →ₗ[ℂ] d.D := d.u (nsGradIdx i j)

/-- The second-derivative mode `u_{i,jj}`. -/
def lapVelocity (i : Fin 3) : d.D →ₗ[ℂ] d.D := d.u (nsLapIdx i)

/-- The full Navier–Stokes term `A_i = ∑_j u_j u_{i,j} − ν u_{i,jj}`. -/
noncomputable def advection (i : Fin 3) : d.D →ₗ[ℂ] d.D :=
  (∑ j : Fin 3, (d.velocity j).comp (d.gradVelocity i j)) - (d.nu : ℂ) • d.lapVelocity i













end NSFullData

end AbstractFull

/-! ## An untruncated instance on `ℓ²(ℤ)`: all fifteen modes, no truncation -/

section Lattice

open BookProof.ChapterContinuityUnitaryInfinite

































end Lattice

/-! ## An **unbounded** untruncated instance on `ℓ²(ℕ)` -/

section Diagonal

open LpNat DiagonalEsa





























end Diagonal

/-! ## Sharpness: the structural hypotheses alone do not give ESA -/

section Sharpness

open LpNat JacobiDeficiency























end Sharpness

end FullEsa

end BookProof.NavierStokesFlow



/-!
# The Ikebe–Kato input in the momentum representation

This module supplies the *analytic* input that the Faris–Lavine route to
essential self-adjointness of the Navier–Stokes Hamiltonian needs, and which was
previously carried as a hypothesis: a comparison operator `N` which

* is self-adjoint on a natural maximal domain,
* is positive (indeed `N ≥ I` for the Navier–Stokes symbol),
* has `N + 1` surjective, and
* admits the finite-mode states (the momentum-representation stand-in for
  `C_c^∞`) as an operator core in the graph norm.

In the momentum representation the one-particle comparison operator
`n = ∑ᵢ πᵢ² + ∑ᵢ Vᵢ² + I` is multiplication by the classical symbol
`σ(k) = ∑ᵢ pᵢ(k)² + ∑ᵢ qᵢ(k)² + 1`
(`BookProof.NavierStokesFlow.FarisLavineLift.diagComparison_eq`).  This is the
momentum-space form of the Ikebe–Kato theorem for `−Δ + V` with `V ≥ 0`: the
operator is essentially self-adjoint on the compactly supported core, and
self-adjoint on its maximal domain.

## Contents

* `maxDom c` and `diagMax c` — multiplication by the real symbol `c` on its
  *maximal* domain in `ℓ²(ι)`, i.e. all states whose image is again square
  summable.
* `diagMax_symmetricOn`, `diagMax_hasSum_quadForm`, `diagMax_quadForm_nonneg`,
  `diagMax_quadForm_ge_norm_sq` — symmetry and positivity of the quadratic form.
* `diagMax_add_one_surjective` — `N + 1` maps the maximal domain **onto** `ℓ²(ι)`
  for a non-negative symbol; this is the one consequence of self-adjointness of
  `N` that the Faris–Lavine argument uses.
* `exists_finiteModes_graph_approx` — the finite-mode states are a **core**: every
  state of the maximal domain is approximated in the graph norm of `N` by finite
  truncations.
* `diagMax_essentiallySelfAdjointOn` — `N` is essentially self-adjoint on its
  maximal domain, and `ikebeKato_momentum` — **essentially self-adjoint already on
  the finite-mode core**.  This is the Ikebe–Kato-type statement, proved here, not
  assumed.
* `essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds` — the payoff: *any*
  symmetric operator `H` on the maximal domain of a non-negative symbol which is
  relatively bounded by `N` and whose form commutator with `N` is dominated by `N`
  is essentially self-adjoint on the finite-mode core.  The Faris–Lavine criterion
  is **not** a hypothesis here: it is the theorem
  `BookProof.FarisLavine.essentiallySelfAdjointOn_core_of_farisLavine`, proved in
  this project.
* `nsComparison_*` — the specialisation to the Navier–Stokes comparison symbol
  `∑ᵢ pᵢ² + ∑ᵢ qᵢ² + 1`, together with `nsComparison_restrict_eq` identifying the
  restriction of `diagMax` to the finite-mode core with the operator
  `ComparisonData.comparison` of `BookProof.ChapterNavierStokesFarisLavineLift`.
* `ns_hamiltonian_essentiallySelfAdjointOn_core` — the assembled one-particle
  statement: the Navier–Stokes Hamiltonian of the fiber momentum representation
  is essentially self-adjoint on the finite-mode core as soon as it satisfies the
  two Faris–Lavine inequalities relative to `n`.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace IkebeKato

open LpNat FarisLavine

variable {ι : Type*}

/-- The Hilbert space `ℓ²(ι)` of the momentum representation. -/
abbrev L2I (ι : Type*) := lp (fun _ : ι => ℂ) 2

/-! ## Square summability helpers -/





/-- A finitely supported function lies in `ℓ²`. -/
theorem memLpTwo_of_finite_support {g : ι → ℂ} (h : (Function.support g).Finite) :
    Memℓp g 2 := by
  classical
  refine memLpTwo_of_summable_normSq (summable_of_ne_finset_zero (s := h.toFinset) ?_)
  intro k hk
  have : g k = 0 := by
    by_contra hne
    exact hk (h.mem_toFinset.mpr hne)
  simp [this]

/-! ## The maximal domain of a multiplication operator -/









/-! ## Symmetry and positivity -/









/-! ## Surjectivity of `N + 1` -/



/-! ## The finite-mode core -/









/-! ## Essential self-adjointness: the Ikebe–Kato input, proved -/







/-! ## The payoff: essential self-adjointness of the Hamiltonian -/



end IkebeKato

end BookProof.NavierStokesFlow



/-!
# Essential self-adjointness of the **full** Navier–Stokes Hamiltonian *after the
Lagrangian change of variables*

`BookProof.ChapterNavierStokesFlow` records the Lagrangian (parcel) change of
variables of `PLAN_LEAN_SPECIALIST_NS_FLOW.md` Part B for a **finite
truncation**: with the Eulerian velocity replaced by the parcel trajectory
`X(ξ)` and its canonical momentum `P(ξ) = Ẋ(ξ) = u(X(ξ))`, the Navier–Stokes
operator becomes the four-term expression

`ĥ_full = −½Δ_X − ν Δ_{ξ,X} − i f(X)·∇_X + Ĥ_constraint`
       ` = ½ ∑ᵢ Pᵢ² + ν ∑ᵢ Qᵢ² + ∑ᵢ fᵢ Dᵢ + C`,

whose first two terms are *positive* second-order operators, the third a
first-order drift and the fourth the zeroth-order volume-preservation
constraint.  `BookProof.ChapterNavierStokesFullEsa` removes the truncation from
the *Eulerian* operator.  This module removes the truncation from the
*transformed* one and proves its essential self-adjointness.

## What is proved here

* `LagrangianFullData` — the untruncated transformed data: a dense domain `D` of
  an arbitrary complex inner-product space, three symmetric parcel momenta `Pᵢ`,
  three symmetric viscous gradients `Qᵢ`, three symmetric drift generators `Dᵢ`
  with a real external force, a symmetric constraint operator and a viscosity
  `ν ≥ 0`.  Nothing is finite-dimensional and nothing is bounded.
* `LagrangianFullData.hFull_isSymmetricDom` — the transformed Hamiltonian is
  symmetric on its domain, unconditionally.
* `LagrangianFullData.kinetic_inner`, `kinetic_nonneg`, `viscous_nonneg` — the
  quadratic forms of the two second-order terms are `½∑‖Pᵢv‖²` and `ν∑‖Qᵢv‖²`:
  after the change of variables the advection term is **positive**, which is the
  structural gain the change of variables is made for.
* `LagrangianFullData.hasZeroDeficiencyOn_of_commonEigenvectors` — **the
  headline criterion**: if the constituents of the transformed operator have a
  total family of common eigenvectors with real eigenvalues in the domain — the
  Lagrangian *momentum representation* — then the full transformed Hamiltonian
  is essentially self-adjoint, with the explicit eigenvalue
  `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`.  Also the flow criterion
  (`hasZeroDeficiencyOn_of_completeUnitaryFlow`) and the bounded-realization
  criterion.
* `hasZeroDeficiencyOn_of_linearIsometryEquiv` and
  `NSFullData.hasZeroDeficiencyOn_of_lagrangian` — **the change of variables
  transfers essential self-adjointness**: vanishing adjoint deficiency is
  invariant under a unitary change of variables, so proving essential
  self-adjointness *after* passing to the Lagrangian variables proves it for the
  Eulerian operator it came from.
* **Two genuinely infinite-dimensional, untruncated instances.**  On `ℓ²(ℤ)`
  the parcel momenta and viscous gradients are the lattice
  (symmetric-difference) momentum — so the kinetic term `½∑Pᵢ²` really is a
  discrete Laplacian — the drift generators and the constraint are
  multiplication by bounded real fields, and the transformed Hamiltonian is
  essentially self-adjoint on the **proper** dense domain of finitely supported
  modes (`latticeLag_hasZeroDeficiencyOn`), and is not the zero operator
  (`latticeLag_hFull_ne_zero`).  On `ℓ²(ℕ)` all the constituents are diagonal
  with arbitrary — in particular unbounded — real symbols, and the transformed
  Hamiltonian is again essentially self-adjoint
  (`diagLag_hasZeroDeficiencyOn`), for a suitable choice genuinely unbounded
  (`diagLag_not_bounded`).
* **Sharpness.**  `exists_lagrangianFullData_not_hasZeroDeficiencyOn`: the
  algebraic shape of the transformed operator is by itself not enough — an
  unbounded first-order *drift* term can already destroy essential
  self-adjointness.  So the criteria above are necessary, not decorative; this
  is the formal counterpart of the `ẋ = x²` warning of the ODE chapter.

## Scope

Essential self-adjointness of the *continuum* transformed Navier–Stokes
generator — and with it global existence for Navier–Stokes — is **not** claimed.
What is proved is: the transformed operator is symmetric and has positive
second-order part in complete generality; it is essentially self-adjoint,
unconditionally, for the two untruncated infinite-dimensional realizations
above; it is essentially self-adjoint under each of three general criteria; and
essential self-adjointness passes back and forth along the change of variables.
By `exists_lagrangianFullData_not_hasZeroDeficiencyOn` no statement about the
abstract transformed data can do better than a criterion of this kind.
-/

namespace BookProof.NavierStokesFlow

namespace LagrangianEsa

open FullEsa

/-! ## The untruncated transformed (Lagrangian) data -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- **The untruncated Lagrangian Navier–Stokes data.**  The parcel momenta `Pᵢ`
(= the Eulerian velocities evaluated along the trajectory, `uᵢ(X(ξ)) = Pᵢ(ξ)`),
the viscous gradients `Qᵢ = ∇_ξPᵢ`, the drift generators `Dᵢ` of the external
force, the zeroth-order volume-preservation constraint `C` and the viscosity
`ν ≥ 0` — now as operators on a *dense domain* `D` of an arbitrary complex
inner-product space. -/
structure LagrangianFullData (F : Type*) [NormedAddCommGroup F]
    [InnerProductSpace ℂ F] where
  /-- The dense domain. -/
  D : Submodule ℂ F
  /-- The parcel momenta: the advection term is `½∑Pᵢ²`. -/
  P : Fin 3 → (D →ₗ[ℂ] D)
  /-- The viscous gradients: the viscosity term is `ν∑Qᵢ²`. -/
  Q : Fin 3 → (D →ₗ[ℂ] D)
  /-- The drift generators of the external force (a first-order term). -/
  drive : Fin 3 → (D →ₗ[ℂ] D)
  /-- The external force. -/
  force : Fin 3 → ℝ
  /-- The zeroth-order volume-preservation (pressure/ghost) constraint. -/
  constraintOp : D →ₗ[ℂ] D
  /-- The kinematic viscosity. -/
  nu : ℝ
  dense : Dense (D : Set F)
  P_symm : ∀ i, IsSymmetricDom (P i)
  Q_symm : ∀ i, IsSymmetricDom (Q i)
  drive_symm : ∀ i, IsSymmetricDom (drive i)
  constraint_symm : IsSymmetricDom constraintOp
  nu_nonneg : 0 ≤ nu

namespace LagrangianFullData

variable (L : LagrangianFullData F)

/-- The advective (kinetic) term `−½Δ_X = ½∑Pᵢ²` — a *positive* second-order
operator after the Lagrangian change of variables. -/
noncomputable def kinetic : L.D →ₗ[ℂ] L.D :=
  ((1 / 2 : ℝ) : ℂ) • ∑ i : Fin 3, (L.P i).comp (L.P i)

/-- The viscous term `−νΔ_{ξ,X} = ν∑Qᵢ²`, second order. -/
noncomputable def viscous : L.D →ₗ[ℂ] L.D :=
  ((L.nu : ℝ) : ℂ) • ∑ i : Fin 3, (L.Q i).comp (L.Q i)

/-- The force drift `∑fᵢDᵢ`, first order. -/
noncomputable def drift : L.D →ₗ[ℂ] L.D :=
  ∑ i : Fin 3, ((L.force i : ℝ) : ℂ) • L.drive i















/-! ### Positivity of the second-order part -/











/-! ### Criteria for essential self-adjointness -/







/-- The eigenvalue of the transformed Hamiltonian on a common eigenvector of its
constituents: `½∑pᵢ² + ν∑qᵢ² + ∑fᵢdᵢ + c`. -/
noncomputable def eigenvalue (p q dr : Fin 3 → ℝ) (c : ℝ) : ℝ :=
  (1 / 2) * (∑ i : Fin 3, p i ^ 2) + L.nu * (∑ i : Fin 3, q i ^ 2)
    + (∑ i : Fin 3, L.force i * dr i) + c





end LagrangianFullData

end Abstract

/-! ## The change of variables transfers essential self-adjointness -/

section ChangeOfVariables

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]









end ChangeOfVariables

/-! ## An untruncated instance on `ℓ²(ℤ)`: the kinetic term is a discrete
Laplacian -/

section Lattice

open FullEsa BookProof.ChapterContinuityUnitaryInfinite

















end Lattice

/-! ## An **unbounded** untruncated instance on `ℓ²(ℕ)` -/

section Diagonal

open LpNat DiagonalEsa FullEsa

















end Diagonal

/-! ## Sharpness: the transformed shape alone does not give ESA -/

section Sharpness

open LpNat JacobiDeficiency FullEsa







end Sharpness

end LagrangianEsa

end BookProof.NavierStokesFlow



/-!
# The Hermite core, and a Strichartz-type theorem on it

This chapter joins the two strands of the project.

`BookProof.ChapterHermiteFunctions` builds the genuine Hermite orthonormal basis
`hermiteBasis` of `L²(ℝ)` (orthogonality, completeness via Fourier uniqueness,
and the harmonic-oscillator eigenvalue equation).  This chapter defines the
**Hermite core**

`hermiteCore = span_ℂ { ψ₀, ψ₁, ψ₂, … } ⊆ L²(ℝ)`,

the finite linear combinations of Hermite functions — i.e. the polynomials times
the Gaussian `e^{-x²/4}` — and proves that a **diagonal operator** in the Hermite
basis, with an arbitrary real symbol `lam : ℕ → ℝ`, is

* symmetric on the core (`hermiteCoreOp_symmetric`),
* has **trivial deficiency at every non-real `z`** (`hermiteCoreOp_deficiencyTrivialAt`),
  which is precisely the Strichartz "finite speed / unique continuation" input, and
* is therefore **essentially self-adjoint on the core**
  (`hermiteCoreOp_essentiallySelfAdjoint`), via the *proved* route
  `BookProof.QuantumGravityDensitized.strichartz_esa_of_finiteSpeed`.

The core is dense (`hermiteCore_dense`), so this is a genuine essential
self-adjointness statement, and the operator is genuinely unbounded whenever the
symbol is (`hermiteCoreOp_not_bounded`).

Finally the result is instantiated with the **3D gauge-fixed quantum-gravity mode
symbol**: after gauge fixing and densitization, the principal symbol of the
gravity Hamiltonian is the hyperbolic form
`qgSymbol ξ ξ_y = (1/16) Σ_{a<3} ξ_a² − (1/24) ξ_y²`
of `BookProof.ChapterQuantumGravityDensitized`, and mode by mode one gets
`qg3DModeSymbol`.  The conclusion is
`qg3D_essentiallySelfAdjoint_on_hermiteCore`: the 3D gauge-fixed quantum-gravity
mode Hamiltonian is essentially self-adjoint on the Hermite core of `L²(ℝ)`.
-/

namespace BookProof.HermiteStrichartzQG

open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine

/-- `L²(ℝ)` with the Lebesgue measure. -/
abbrev L2R := Lp ℂ 2 (volume : Measure ℝ)









/-! ## The Hermite core -/

/-- **The Hermite core**: the finite linear combinations of Hermite functions,
i.e. the polynomials times the Gaussian `e^{-x²/4}`, as a submodule of `L²(ℝ)`. -/
noncomputable def hermiteCore : Submodule ℂ L2R := Submodule.span ℂ (Set.range hermiteLp)





/-! ## Diagonal operators in the Hermite basis -/















/-! ## Symmetry, deficiency, essential self-adjointness -/











/-! ## The harmonic oscillator on the Hermite core -/









/-! ## The 3D gauge-fixed quantum-gravity Hamiltonian -/















end BookProof.HermiteStrichartzQG



/-!
# Essential self-adjointness of the wave operator on the Schwartz core

This module proves that the d'Alembertian

$$\Box = -\partial_t^2 + \Delta_x$$

on spacetime `ℝ^{1+n}`, together with a real constant potential, is **essentially
self-adjoint** on `L²(ℝ^{1+n})` when taken on the Schwartz core.  This is the
Strichartz-type statement for hyperbolic wave operators: the (formally symmetric)
operator has vanishing deficiency indices, so it possesses exactly one self-adjoint
extension.

The proof follows the Fourier-multiplier route, which for a *constant-coefficient*
operator replaces the light-cone cut-off/energy estimates of the variable-coefficient
theory:

* Under the Fourier transform (a unitary of `L²` by Plancherel, available in Mathlib as
  `MeasureTheory.Lp.fourierTransformₗᵢ`) the operator `∑ i, c i • ∂_{w i}² + κ` becomes
  multiplication by the **real** symbol
  `symbolFn c w κ ξ = ∑ i, c i * (-4π²) * ⟪ξ, w i⟫² + κ`.
* Symmetry is then immediate from realness of the symbol.
* For the deficiency spaces: if `u ∈ L²` satisfies `⟪P v, u⟫ = z ⟪v, u⟫` for all `v` in
  the core and `Im z ≠ 0`, put `g = 𝓕 u`.  Given any smooth compactly supported real
  `χ`, the function `ψ = χ / (symbol - conj z)` is again smooth with compact support
  (the denominator never vanishes because the symbol is real), hence Schwartz, and
  testing against `v = 𝓕⁻¹ ψ` gives `∫ χ • g = 0`.  As `χ` is arbitrary, `g = 0`, so
  `u = 0`.

Everything is proved in the general setting of a finite-dimensional real inner product
space `V` and an arbitrary finite family of directions `w : ι → V` with real
coefficients `c : ι → ℝ`; the Minkowski signature `c = (-1, 1, …, 1)` gives the wave
operator, and `c = (1, …, 1)` gives the Laplacian.

Essential self-adjointness is expressed with the deficiency-space predicates of
`BookProof.ChapterFarisLavine` (`BookProof.FarisLavine.EssentiallySelfAdjointOn`), which
are used throughout this project.
-/

namespace BookProof.StrichartzWave

open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]
variable {ι : Type*} [Fintype ι]

/-! ## The operator and its symbol -/

/-- The second directional derivative `∂_m ∂_m` as a continuous linear map on Schwartz
space. -/
noncomputable def secondDeriv (m : V) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  lineDerivOpCLM ℂ 𝓢(V, ℂ) m ∘L lineDerivOpCLM ℂ 𝓢(V, ℂ) m

/-- The constant-coefficient operator `∑ i, c i • ∂_{w i}² + κ` on Schwartz space.  For the
Minkowski signature `c = (-1, 1, …, 1)` and the standard coordinate directions this is the
d'Alembertian `□ = -∂_t² + Δ_x` plus the constant potential `κ`. -/
noncomputable def constCoeffOp (c : ι → ℝ) (w : ι → V) (κ : ℝ) : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ) :=
  (∑ i, (c i : ℂ) • secondDeriv (w i)) + (κ : ℂ) • ContinuousLinearMap.id ℂ 𝓢(V, ℂ)

/-- The (real!) symbol of `constCoeffOp c w κ`: with Mathlib's Fourier convention
`𝓕 f ξ = ∫ e^{-2πi⟪x,ξ⟫} f x`, the operator `∂_m²` becomes multiplication by
`-4π²⟪ξ, m⟫²`. -/
noncomputable def symbolFn (c : ι → ℝ) (w : ι → V) (κ : ℝ) (x : V) : ℝ :=
  (∑ i, c i * (-4 * Real.pi ^ 2) * (inner ℝ x (w i)) ^ 2) + κ

lemma fourier_secondDeriv_apply (f : 𝓢(V, ℂ)) (m : V) (x : V) :
    (𝓕 (secondDeriv m f) : 𝓢(V, ℂ)) x
      = ((-4 * Real.pi ^ 2 * (inner ℝ x m) ^ 2 : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by
  have h : (inner ℝ · m : V → ℝ).HasTemperateGrowth := ((innerSL ℝ).flip m).hasTemperateGrowth
  change (𝓕 (∂_{m} (∂_{m} f) : 𝓢(V, ℂ)) : 𝓢(V, ℂ)) x = _
  rw [fourier_lineDerivOp_eq, fourier_lineDerivOp_eq]
  simp only [h, smulLeftCLM_apply, SchwartzMap.smul_apply, smul_eq_mul, Complex.real_smul,
    Complex.ofReal_mul, Complex.ofReal_neg, Complex.ofReal_pow, Complex.ofReal_ofNat]
  rw [show ((2 : ℂ) * Real.pi * Complex.I) * (((inner ℝ x m : ℝ) : ℂ) *
      (((2 : ℂ) * Real.pi * Complex.I) * (((inner ℝ x m : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x))) =
      (Complex.I ^ 2) * (4 * (Real.pi : ℂ) ^ 2 * ((inner ℝ x m : ℝ) : ℂ) ^ 2 *
        (𝓕 f : 𝓢(V, ℂ)) x) by ring, Complex.I_sq]
  ring

/-- Under the Fourier transform the constant-coefficient operator becomes multiplication by
its symbol. -/
lemma fourier_constCoeffOp_apply (c : ι → ℝ) (w : ι → V) (κ : ℝ) (f : 𝓢(V, ℂ)) (x : V) :
    (𝓕 (constCoeffOp c w κ f) : 𝓢(V, ℂ)) x
      = ((symbolFn c w κ x : ℝ) : ℂ) * (𝓕 f : 𝓢(V, ℂ)) x := by
  have hlin : (𝓕 (constCoeffOp c w κ f) : 𝓢(V, ℂ))
      = (∑ i, (c i : ℂ) • (𝓕 (secondDeriv (w i) f) : 𝓢(V, ℂ))) + (κ : ℂ) • (𝓕 f : 𝓢(V, ℂ)) := by
    change fourierTransformCLM ℂ (constCoeffOp c w κ f) = _
    simp [constCoeffOp]
  rw [hlin]
  simp only [SchwartzMap.add_apply, SchwartzMap.sum_apply, SchwartzMap.smul_apply, smul_eq_mul,
    fourier_secondDeriv_apply, symbolFn, Complex.ofReal_add, Complex.ofReal_sum,
    Complex.ofReal_mul, Complex.ofReal_neg, Complex.ofReal_pow, Complex.ofReal_ofNat,
    Finset.sum_mul, add_mul]
  congr 1
  exact Finset.sum_congr rfl fun i _ => by ring



/-! ## The operator on `L²` -/

/-- The Schwartz core, as a submodule of `L²`. -/
noncomputable def schwartzDomain (V : Type*) [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] :
    Submodule ℂ (Lp ℂ 2 (volume : Measure V)) :=
  LinearMap.range (toLpCLM ℂ ℂ 2 (volume : Measure V)).toLinearMap

/-- Schwartz functions are in bijection with the Schwartz core of `L²`. -/
noncomputable def schwartzEquiv (V : Type*) [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] :
    𝓢(V, ℂ) ≃ₗ[ℂ] schwartzDomain V :=
  LinearEquiv.ofInjective (toLpCLM ℂ ℂ 2 (volume : Measure V)).toLinearMap
    (SchwartzMap.injective_toLp 2 (volume : Measure V))

/-- An operator on Schwartz space, viewed as an unbounded operator on `L²` with the Schwartz
core as its domain. -/
noncomputable def opL2 (T : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) :
    schwartzDomain V →ₗ[ℂ] Lp ℂ 2 (volume : Measure V) :=
  (toLpCLM ℂ ℂ 2 (volume : Measure V)).toLinearMap ∘ₗ T.toLinearMap ∘ₗ
    (schwartzEquiv V).symm.toLinearMap

@[simp] lemma opL2_apply (T : 𝓢(V, ℂ) →L[ℂ] 𝓢(V, ℂ)) (f : 𝓢(V, ℂ)) :
    opL2 T (schwartzEquiv V f) = (T f).toLp 2 (volume : Measure V) := by
  simp [opL2, schwartzEquiv]

@[simp] lemma schwartzEquiv_coe (f : 𝓢(V, ℂ)) :
    ((schwartzEquiv V f : schwartzDomain V) : Lp ℂ 2 (volume : Measure V))
      = f.toLp 2 (volume : Measure V) := rfl

/-! ## Elementary `L²` identities -/

/-- The `L²` pairing of a Schwartz function with an `L²` function, as an integral. -/
lemma inner_toLp_left (f : 𝓢(V, ℂ)) (u : Lp ℂ 2 (volume : Measure V)) :
    (inner ℂ (f.toLp 2 (volume : Measure V)) u : ℂ)
      = ∫ x, (starRingEnd ℂ) (f x) * (u x) := by
  rw [MeasureTheory.L2.inner_def]
  refine integral_congr_ae ?_
  filter_upwards [f.coeFn_toLp 2 (volume : Measure V)] with x hx
  rw [hx]
  simp [RCLike.inner_apply, mul_comm]



/-- The `L²` pairing of two Schwartz functions, computed on the Fourier side. -/
lemma inner_toLp_eq_integral_fourier (f g : 𝓢(V, ℂ)) :
    (inner ℂ (f.toLp 2 (volume : Measure V)) (g.toLp 2 (volume : Measure V)) : ℂ)
      = ∫ x, (starRingEnd ℂ) ((𝓕 f : 𝓢(V, ℂ)) x) * ((𝓕 g : 𝓢(V, ℂ)) x) := by
  rw [← MeasureTheory.Lp.inner_fourier_eq (f.toLp 2 (volume : Measure V))
      (g.toLp 2 (volume : Measure V)), SchwartzMap.toLp_fourier_eq, SchwartzMap.toLp_fourier_eq,
    inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [(𝓕 g : 𝓢(V, ℂ)).coeFn_toLp 2 (volume : Measure V)] with x hx
  rw [hx]



/-! ## Symmetry -/

/-- The constant-coefficient operator with real coefficients is symmetric on the Schwartz
core. -/
theorem constCoeffOp_symmetric (c : ι → ℝ) (w : ι → V) (κ : ℝ) :
    BookProof.FarisLavine.SymmetricOn (schwartzDomain V) (opL2 (constCoeffOp c w κ)) := by
  intro x y
  obtain ⟨f, rfl⟩ := (schwartzEquiv V).surjective x
  obtain ⟨g, rfl⟩ := (schwartzEquiv V).surjective y
  rw [opL2_apply, opL2_apply, schwartzEquiv_coe, schwartzEquiv_coe,
    inner_toLp_eq_integral_fourier, inner_toLp_eq_integral_fourier]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only [fourier_constCoeffOp_apply, map_mul, Complex.conj_ofReal]
  ring

/-! ## Vanishing deficiency spaces -/







/-! ## Smooth cut-off functions

The Fourier-multiplier proof above needs no cut-offs, but the cut-off functions of the
variable-coefficient (energy-estimate) theory are recorded here: for every radius `R`
there is a smooth compactly supported `χ` with values in `[0,1]` which equals `1` on the
ball of radius `R` and has a bounded gradient. -/



/-! ## The wave operator on spacetime -/













end BookProof.StrichartzWave



/-!
# The unbounded layer: a self-adjoint operator on `ℓ²(ℤ)` and the group it generates

Source: the *Boundary* paragraphs of proof plan appendix §E
(`Book/ProofPlans.lean`) and the `ConditionalUnitary` chapter — everything the
book formalizes about the dynamics-based unitary is carried by *bounded*
operators (matrices on the cyclic lattice in
`BookProof.ChapterContinuityUnitary`, bounded operators on `ℓ²(ℤ)` in
`BookProof.ChapterContinuityUnitaryInfinite`, a bounded self-adjoint generator on
`L²(μ)` in `BookProof.ChapterBornMeasure`).  The remaining open layer is
*unboundedness*.

This module makes that layer precise rather than rhetorical.  For a real
"multiplier" `f : ℤ → ℝ` — the lattice position field `f k = k` being the case of
interest — it builds the multiplication operator on its **natural domain**

  `D(f) = {ψ ∈ ℓ²(ℤ) : f · ψ ∈ ℓ²(ℤ)}`

(a submodule, `mulDomain`), proves that this domain is **dense**
(`mulDomain_dense`, via the finitely supported vectors), that the operator is
**symmetric** on it (`mulOp_symmetric`), and that for the position field it is
genuinely **unbounded** (`position_unbounded`): no constant `C` satisfies
`‖x̂ψ‖ ≤ C‖ψ‖` on the domain.  So the object here is not a bounded operator in
disguise; it is the first honest instance of the unbounded layer, and
`position_not_boundedOperator` records that it is not the restriction of any
bounded operator either.

The module then goes past symmetry in the two directions that matter for the
book's claim.

* **Self-adjointness.**  `adjointDomain_eq_mulDomain` shows the adjoint domain is
  *exactly* `D(f)` — nothing larger — and `adjoint_eq_mulOp` shows the adjoint
  acts by multiplication there.  So the maximal multiplication operator, position
  included, is a genuine self-adjoint observable, not merely a symmetric one.
* **The unitary group.**  `phaseUnitary f t` is the pointwise phase
  `ψ k ↦ exp(i t f k) ψ k`, a `LinearIsometryEquiv` of `ℓ²(ℤ)`
  (`phaseUnitary_zero`, `phaseUnitary_add` give the one-parameter group law),
  strongly continuous at `0` for *every* state (`tendsto_phaseUnitary`), whose
  generator is the unbounded operator: for `ψ ∈ D(f)` the difference quotient
  converges in `ℓ²(ℤ)` to `i·f·ψ` (`tendsto_slope_phaseUnitary`), which is
  Stone's relation `dU/dt|₀ = iA` for an unbounded self-adjoint `A`.

What therefore remains genuinely open is *not* "symmetric ⟹ self-adjoint ⟹ a
unitary group" — that implication is discharged here for multiplication
operators — but the same package for unbounded operators that are not
multiplication operators in the ambient basis (a continuum Laplacian, say), i.e.
Stone's theorem in full generality.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped ENNReal InnerProductSpace

namespace BookProof.ChapterUnboundedPosition

open (L2Z) BookProof.ChapterContinuityUnitaryInfinite

/-! ## The natural domain of a multiplication operator -/

/-- The **natural domain** `D(f) = {ψ ∈ ℓ²(ℤ) : f·ψ ∈ ℓ²(ℤ)}` of multiplication
by a real field `f`, as a submodule of `ℓ²(ℤ)`. -/
def mulDomain (f : ℤ → ℝ) : Submodule ℂ L2Z where
  carrier := {psi : L2Z | Memℓp (fun k => (f k : ℂ) * (psi : ℤ → ℂ) k) 2}
  zero_mem' := by
    simp only [Set.mem_setOf_eq, lp.coeFn_zero, Pi.zero_apply, mul_zero]
    exact zero_memℓp
  add_mem' := by
    intro a b ha hb
    have heq : (fun k => (f k : ℂ) * ((a + b : L2Z) : ℤ → ℂ) k)
        = (fun k => (f k : ℂ) * (a : ℤ → ℂ) k) + fun k => (f k : ℂ) * (b : ℤ → ℂ) k := by
      funext k
      simp [mul_add]
    change Memℓp _ 2
    rw [heq]
    exact ha.add hb
  smul_mem' := by
    intro c a ha
    have heq : (fun k => (f k : ℂ) * ((c • a : L2Z) : ℤ → ℂ) k)
        = c • fun k => (f k : ℂ) * (a : ℤ → ℂ) k := by
      funext k
      simp [mul_left_comm]
    change Memℓp _ 2
    rw [heq]
    exact ha.const_smul c



/-- Multiplication by `f`, on its natural domain. -/
noncomputable def mulOp (f : ℤ → ℝ) : mulDomain f →ₗ[ℂ] L2Z where
  toFun psi := ⟨fun k => (f k : ℂ) * ((psi : L2Z) : ℤ → ℂ) k, psi.2⟩
  map_add' a b := by ext k; simp [mul_add]
  map_smul' c a := by
    ext k
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply, Submodule.coe_smul]
    ring





/-! ## The domain is dense -/







/-! ## The position field really is unbounded -/







/-! ## The adjoint: the maximal multiplication operator is self-adjoint -/





/-- The domain of the adjoint of multiplication by `f`. -/
def adjointDomain (f : ℤ → ℝ) : Set L2Z :=
  {phi | ∃ eta : L2Z, ∀ psi : mulDomain f, ⟪mulOp f psi, phi⟫_ℂ = ⟪(psi : L2Z), eta⟫_ℂ}







/-! ## The unitary group generated by the multiplication operator -/



































end BookProof.ChapterUnboundedPosition



/-!
# Quantum Yang–Mills: the Weyl-gauge form and its closability (the Friedrichs route)

Source: `book.tex`, chapter *"Quantization due to time-evolution: Yang-Mills and
Classical Statistical Field Theory"*, §*"Pure SU(3) Yang-Mills theory"*
(~7037–7120), and the plan item recorded in `CONSOLIDATED_PLAN.md` §11 (Parts
A–D of the suggested `PLAN_LEAN_SPECIALIST_QYM_FLOW.md`).

In the Weyl gauge and in the Hermite (oscillator) basis the gauge-fixed
Yang–Mills Hamiltonian is a **sum of squares** of the self-adjoint electric-field
operators `πⁱ_a` and magnetic-field operators `B_{i a}`,

  `H = ½ Σ (πⁱ_a)² + ½ Σ (B_{i a})²`,

hence symmetric and bounded below by `0`.  `BookProof.ChapterWeylHamiltonian`
proves this for *bounded* fields; the Friedrichs route needs the same statement
for a **densely defined** operator on a domain, together with the closability of
its quadratic form — that is what this module supplies.

## What is proved here (all `sorry`-free and `axiom`-free)

**Part A — the Weyl-gauge Hamiltonian on a domain.**

* `weylOpDom` — `H = ½ Σ πᵢ² + ½ Σ Bₐ²` as an operator `D →ₗ[ℂ] D`;
* `weylOpDom_symmetricOn` — it is symmetric on `D`;
* `weylOpDom_quadForm` — its quadratic form is the **sum of squares**
  `q(x) = ½ Σ ‖πᵢ x‖² + ½ Σ ‖Bₐ x‖²`;
* `weylOpDom_quadForm_nonneg` — hence `H ≥ 0`: the operator is semi-bounded, the
  hypothesis of the Friedrichs extension theorem.

**Part B — the quadratic form and its closure.**  For an arbitrary symmetric,
positive operator `H` on a domain `D`:

* `formInner`, `formNormSq` — the form inner product `⟪x,y⟫ + ⟪x, H y⟫` and the
  associated form norm;
* `formInner_conj_symm`, `formNormSq_ge_normSq` — it is a Hermitian form
  dominating the ambient norm (`‖x‖² ≤ q(x)`), so it *is* an inner product;
* `formNormSq_add`, `formNormSq_add_le`, `re_formInner_sq_le` — the expansion of
  the form norm and its **Cauchy–Schwarz inequality**;
* `form_closable` — **the headline of Part B.**  *The form is closable*: if a
  sequence is Cauchy in the form norm and tends to `0` in the ambient space, then
  its form norm tends to `0`.  This is exactly the step that makes the
  Friedrichs construction well defined (the form closure has no "ghost"
  elements), and it is where symmetry and positivity of `H` are used;
* `weylForm_closable` — the Weyl-gauge form of Part A is closable.

**Part C — the Friedrichs extension, as a named theorem (never an axiom).**

* `friedrichs_extension_of_semibounded` — the classical theorem (K. Friedrichs,
  *Spektraltheorie halbbeschränkter Operatoren*, Math. Ann. **109** (1934)
  465–487; M. Reed & B. Simon, *Methods of Modern Mathematical Physics* I/II,
  Thm X.23) enters as an explicit hypothesis and is applied to the Weyl-gauge
  operator: a densely defined symmetric positive operator has a self-adjoint
  positive extension.
* `friedrichs_hypothesis_satisfiable` — the named hypothesis is **not vacuous**:
  it holds (with the operator as its own extension) whenever the domain is the
  whole space, which is the bounded Weyl case of
  `BookProof.ChapterWeylHamiltonian`.
* `weyl_friedrichs_extension` — the conclusion for the Weyl-gauge Hamiltonian,
  conditional on that named theorem.

**Part D — the Hashimoto/SIRK limit (research conjecture, recorded not claimed).**

* `weylKrylov_bestApprox_antitone`, `weylKrylov_bestApprox_tendsto_zero` — the
  *proved* supporting facts, specialized to the Weyl-gauge generator: the Krylov
  (Hashimoto order-`n`) best-approximation error is antitone in the order and
  tends to `0` for a cyclic seed;
* the conjecture of `CONSOLIDATED_PLAN.md` §11.2 ("the infinite Hashimoto limit
  selects the Friedrichs extension") is **recorded in prose** in Part D and is
  neither stated as a Lean theorem nor proved: its formalization needs the limit
  operator of the Krylov flag, which is not constructed here.

## Scope

Nothing here claims self-adjointness of the continuum Yang–Mills operator on
`L²(ℝ⁹⁹ × ℤ₂³¹)`, nor a mass gap, nor global existence.  The Millennium problem
is out of scope; the Friedrichs theorem itself is a *hypothesis*, and the
Hashimoto-limit identification is recorded as a conjecture.
-/

namespace BookProof.YangMillsFriedrichs

open BookProof.FarisLavine

/-! ## Part B (general theory) — the form of a positive symmetric operator

We develop the form first, since Part A is an instance of it. -/

section Form

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}



































end Form

/-! ## Part A — the Weyl-gauge Hamiltonian on a domain -/

section Weyl

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

















end Weyl

/-! ## Part C — the Friedrichs extension as a named theorem -/

section Friedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- The statement "`A` on the domain `Dom` is a positive self-adjoint extension
of `H` on `D`", spelled out: `Dom` contains `D`, `A` agrees with `H` there, `A`
is symmetric and positive, and the adjoint of `A` is `A` itself (every vector
that behaves like a domain vector *is* one). -/
def IsPositiveSelfAdjointExtension {D Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (A : Dom →ₗ[ℂ] F) :
    Prop :=
  (∀ x : D, ∃ h : (x : F) ∈ Dom, A ⟨(x : F), h⟩ = H x) ∧ SymmetricOn Dom A ∧
    (∀ y : Dom, 0 ≤ quadForm A y) ∧
    (∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)







end Friedrichs

/-! ## Part D — the Hashimoto/SIRK limit: proved supporting facts, and the
conjecture written down -/

section Sirk


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]





/- **The conjecture of `CONSOLIDATED_PLAN.md` §11.2 — recorded, not stated as a
Lean theorem.**  *The operator recovered in the infinite Hashimoto/SIRK limit is
the Friedrichs extension.*  Formalizing it requires the limit operator of the
Krylov flag, which is exactly the piece that is not constructed here; the two
theorems above are the proved facts that support it (nesting and, for a cyclic
seed, convergence of the best-approximation error).  It is deliberately not
written as a Lean statement, because every naive rendering of it is either
trivially true (all extensions agree on the original domain by definition) or
requires the unformalized limit. -/

end Sirk

end BookProof.YangMillsFriedrichs



/-!
# The shift-invert (Hashimoto) trick: the Galerkin/Friedrichs selection theorem
for **unbounded** Hamiltonians

`BookProof.ChapterHermiteGalerkinFriedrichs` proves that a Galerkin/Rayleigh–Ritz
truncation in a complete (Hermite) basis converges — strongly, and in the strong
resolvent sense — to the positive self-adjoint (Friedrichs) extension of the
matrix it is fed, under a standing hypothesis that the operator is **bounded**
on its domain.

That hypothesis is not a restriction on the *physics* the Hashimoto algorithm
does, because the algorithm never applies `H` itself: it applies the
*shift-inverted* operator `R = (H + γ)⁻¹`.  And `R` is bounded — indeed
`‖R‖ ≤ 1/γ` — for **every** positive symmetric `H`, however unbounded, purely
because of positivity.  This module makes that precise and closes the gap:

* `norm_shiftMap_ge` — the shift bound `‖(A + γ)x‖ ≥ γ‖x‖` for a positive
  symmetric operator.  This is why the *effective* Hamiltonian is bounded even
  when `H` is not.
* `closed_of_selfAdjointCriterion`, `shiftRange_isClosed`, `shiftRange_dense`,
  `shiftMap_surjective` — for a positive self-adjoint operator (in the sense of
  `IsPositiveSelfAdjointExtension`) the shifted operator `A + γ` is a bijection
  of its domain onto the whole space.  No boundedness is used.
* `IsShiftInvert`, `exists_isShiftInvert` — hence the bounded inverse
  `R = (A + γ)⁻¹` exists as a genuine element of `F →L[ℂ] F`, with
  `‖R‖ ≤ γ⁻¹` (`IsShiftInvert.opNorm_le`), self-adjoint
  (`IsShiftInvert.isSelfAdjoint`), positive and injective.
* `IsShiftInvert.dom_eq_range`, `IsShiftInvert.apply_eq`,
  `shiftInvert_determines` — `R` remembers everything: its range is the domain
  of `A`, and `A = R⁻¹ − γ` there.  Two positive self-adjoint operators with the
  same shift-invert are the same operator.
* `galerkinCompression_shiftInvert_tendsto`,
  `galerkinResolvent_shiftInvert_tendsto` — the bounded Galerkin theory of
  `BookProof.ChapterHermiteGalerkinFriedrichs` applies verbatim to `R`.
* `hashimoto_shiftInvert_selects_friedrichs` — the headline, **with no
  boundedness hypothesis anywhere**: for a symmetric positive matrix in a
  complete basis and any positive self-adjoint extension `A` of it (the
  Friedrichs extension being one), the shift-inverted operator `R = (A+γ)⁻¹` is
  bounded, the Galerkin truncations of `R` converge strongly to `R` (this is
  precisely strong resolvent convergence of the truncations to `A`), and `R`
  determines `A` uniquely — so the algorithm selects that extension and no
  other.
* `ell2UnboundedExample` and `unbounded_shiftInvert_example` — the hypotheses
  are satisfied by a genuinely **unbounded** operator: the diagonal operator
  `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)`, whose shift-invert at `γ = 1` is the bounded
  diagonal operator `eₙ ↦ eₙ/(n+1)`.  The boundedness hypothesis of
  `hermiteGalerkin_selects_friedrichs` fails for this `A`
  (`ell2UnboundedExample_unbounded`), while the theorems here apply.

This module treats one **real positive** shift `γ`, where invertibility of
`A + γ` comes from positivity of `A`.  The shifts the Shift-invert Rational
Krylov method actually uses are complex with non-zero imaginary part (which
makes `γ I − A` invertible for every self-adjoint `A`, positive or not), and
they change from step to step; that generalisation, in the same namespace, is
`BookProof.ChapterHashimotoComplexShifts`, whose
`isShiftInvertC_neg_of_isShiftInvert` relates the two notions.
-/

namespace BookProof.HashimotoShiftInvert

open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open Filter Topology

/-! ## Part 1 — the shift bound: why the effective Hamiltonian is bounded -/

section Bound

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}









end Bound

/-! ## Part 2 — for a positive self-adjoint operator the shift is a bijection -/

section Surjective

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}










end Surjective

/-! ## Part 3 — the shift-inverted operator `R = (A + γ)⁻¹` -/

section ShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}



























end ShiftInvert

/-! ## Part 3b — the converse: the operator defined by a bounded shift-invert

Running the construction backwards turns a bounded, injective, positive
self-adjoint `R` into the (generally unbounded) operator `A = R⁻¹ − γ` of which
it is the shift-invert.  This is how one exhibits genuinely unbounded examples,
and it shows the notion `IsShiftInvert` is not vacuous. -/

section Converse

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- A preimage under an operator, chosen on its range. -/
noncomputable def preim (R : F →L[ℂ] F) (y : LinearMap.range (R : F →ₗ[ℂ] F)) : F :=
  (LinearMap.mem_range.mp y.2).choose

omit [CompleteSpace F] in
@[simp] theorem preim_spec (R : F →L[ℂ] F) (y : LinearMap.range (R : F →ₗ[ℂ] F)) :
    R (preim R y) = (y : F) := (LinearMap.mem_range.mp y.2).choose_spec

omit [CompleteSpace F] in
theorem preim_eq (R : F →L[ℂ] F) (hinj : Function.Injective R)
    (y : LinearMap.range (R : F →ₗ[ℂ] F)) {u : F} (hu : R u = (y : F)) : preim R y = u :=
  hinj (by rw [preim_spec, hu])

/-- **The operator whose shift-invert is `R`**: `A = R⁻¹ − γ`, defined on the
range of `R`. -/
noncomputable def invShiftOperator (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ) :
    LinearMap.range (R : F →ₗ[ℂ] F) →ₗ[ℂ] F where
  toFun y := preim R y - (γ : ℂ) • (y : F)
  map_add' y z := by
    have h : preim R (y + z) = preim R y + preim R z := by
      apply hinj
      rw [preim_spec, map_add, preim_spec, preim_spec]
      rfl
    rw [h]
    push_cast [Submodule.coe_add]
    module
  map_smul' a y := by
    have h : preim R (a • y) = a • preim R y := by
      apply hinj
      rw [preim_spec, map_smul, preim_spec]
      rfl
    simp only [RingHom.id_apply, h]
    push_cast [Submodule.coe_smul]
    module

omit [CompleteSpace F] in
@[simp] theorem invShiftOperator_apply (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ)
    (y : LinearMap.range (R : F →ₗ[ℂ] F)) :
    invShiftOperator R hinj γ y = preim R y - (γ : ℂ) • (y : F) := rfl



/-- The operator defined by a self-adjoint `R` is symmetric. -/
theorem invShiftOperator_symmetricOn (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ)
    (hR : IsSelfAdjoint R) :
    SymmetricOn (LinearMap.range (R : F →ₗ[ℂ] F)) (invShiftOperator R hinj γ) := by
  have hRsym := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hR
  intro y z
  have hy : R (preim R y) = (y : F) := preim_spec R y
  have hz : R (preim R z) = (z : F) := preim_spec R z
  have hcross : (inner ℂ (preim R y) (z : F) : ℂ) = inner ℂ (y : F) (preim R z) := by
    rw [← hy, ← hz]
    exact (hRsym (preim R y) (preim R z)).symm
  simp only [invShiftOperator_apply, inner_sub_left, inner_sub_right, inner_smul_left,
    inner_smul_right, Complex.conj_ofReal, hcross]

omit [CompleteSpace F] in
/-- The operator defined by `R` is positive exactly when `R ≤ 1/γ` in the sense
of quadratic forms. -/
theorem invShiftOperator_quadForm_nonneg (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ)
    (hposR : ∀ u : F, γ * ‖R u‖ ^ 2 ≤ (inner ℂ (R u) u : ℂ).re)
    (y : LinearMap.range (R : F →ₗ[ℂ] F)) : 0 ≤ quadForm (invShiftOperator R hinj γ) y := by
  have hy : R (preim R y) = (y : F) := preim_spec R y
  have hq : quadForm (invShiftOperator R hinj γ) y
      = (inner ℂ (y : F) (preim R y) : ℂ).re - γ * ‖(y : F)‖ ^ 2 := by
    rw [quadForm, invShiftOperator_apply, inner_sub_right, inner_smul_right, Complex.sub_re,
      inner_self_eq_norm_sq_to_K]
    congr 1
    simp [← Complex.ofReal_pow]
  have hp := hposR (preim R y)
  rw [hy] at hp
  rw [hq]
  linarith





end Converse

/-! ## Part 4 — the Galerkin theory applies to the effective Hamiltonian -/

section Galerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}





end Galerkin

/-! ## Part 5 — the headline: no boundedness hypothesis -/

section Headline

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]



end Headline

/-! ## Part 6 — a genuinely unbounded example -/

section Example

open scoped InnerProductSpace ENNReal

/-! ### The diagonal operator on `ℓ²(ℕ, ℂ)` -/





















/-! ### The unbounded example: `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)` -/















































end Example

end BookProof.HashimotoShiftInvert



/-!
# The differential realization of the Navier–Stokes quadratic symbol on `L²(du₁du₂du₃)`

`BookProof.ChapterNavierStokesThreeComponent` proves that the coupled three-component
fiber Hamiltonian `H = ∑ᵢ ½(πᵢVᵢ + Vᵢπᵢ)`, `Vᵢ(u) = ∑ₖ A_{ik}u_k + c_i`, is essentially
self-adjoint on the finite-mode core of `ℓ²(Vel)`, `Vel = Fin 3 → ℕ`, and
`BookProof.ChapterNavierStokesCanonicalVector` shows that this sequence-space matrix *is*
the Weyl-ordered expression in the abstract ladder operators of that space.  What both
modules record as the honest open step is the **differential realization**: the operator
written with `πᵢ = −i ∂/∂uᵢ` and `uᵢ` a genuine multiplication operator, on the Hermite
core of `L²(du₁du₂du₃)`.  This module takes that step.

## The setting

The Hilbert space is `L²(ℝ³)` and the dense domain is the Gauss–polynomial (product
Hermite) core `polyGaussCore` of `BookProof.ChapterHermiteProductCore`: the functions
`p(u)·e^{-‖u‖²/4}` with `p` a polynomial.  Since `pgMap` is injective, the core carries the
polynomial coordinates `coreEquiv`, and an operator on the core is given by a polynomial
operator (`coreOp`).  Two such operators are the physical ones:

* `posOp i` — multiplication by the coordinate `uᵢ` (`pgFun_mulXPoly`);
* `momOp i` — the differential operator `πᵢ = −i ∂/∂uᵢ`.  That it *is* the derivative is
  `momOp_apply_eq_differential`: the value of `momOp i` at `p·e^{-‖u‖²/4}` is, pointwise,
  `−i` times the honest derivative `deriv (fun t => f (u with uᵢ := t)) uᵢ` of the function
  along the `i`-th coordinate (Mathlib's `deriv`, `hasDerivAt_pgFun_sec`).

`comm_momOp_posOp` is the canonical commutation relation `[πᵢ, u_k] = −i δ_{ik}` for these
genuinely differential operators.

## The Hamiltonian and the transport

`nsDiffH A c = ∑ᵢ ½(πᵢ Vᵢ + Vᵢ πᵢ)` with `Vᵢ` the multiplication operator by the affine
field `∑ₖ A_{ik}u_k + c_i` is the Weyl quantization of the Navier–Stokes quadratic symbol
`A_i(u) = u_j u_{i,j} − ν u_{i,jj}` at one Eulerian fiber (linear part the velocity
gradient, constant part `−ν` times the velocity Laplacian).

The **unitary transport** is `velUnitary : ℓ²(Vel) ≃ₗᵢ L²(ℝ³)`, the Hilbert-basis
isomorphism given by the product Hermite functions
(`BookProof.ChapterHermiteProductBasis`).  It carries the finite-mode core onto the
Gauss–polynomial core (`map_finiteModes`) and the abstract ladder operators onto the
differential ones (`intertwine_ann`, `intertwine_cre`), hence the abstract canonical
Hamiltonian onto the differential one (`conj_canH`).  The conclusions:

* `nsDiffH_essentiallySelfAdjointOn_core` — the **differentially written** Navier–Stokes
  quadratic symbol is essentially self-adjoint on the Hermite core of `L²(ℝ³)`, for every
  real velocity gradient and every constant part;
* `nsQuadraticDiffH_essentiallySelfAdjointOn_core` — the same with the coefficients spelled
  out as `(ν, u_{i,j}, u_{i,jj})`;
* `nsDiffH_not_bounded`, `polyGaussCore_dense_L2` — the operator is genuinely unbounded and
  the domain is dense, so the statement is not a bounded-operator artefact.

## Honest boundary

Nothing here claims global regularity of the *classical* Navier–Stokes PDE (Contention D5,
the deliberate scope cut): the theorem is about the Hilbert-space operator at one Eulerian
fiber, where the derivative fields `u_{i,j}`, `u_{i,jj}` are independent canonical
coordinates.
-/

namespace BookProof.NavierStokesFlow.DifferentialL2

open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LpNat BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.CanonicalVector
open BookProof.NavierStokesFlow.LagrangianEsa

noncomputable section

/-! ## Differentiating along one coordinate -/

variable {d : ℕ}

















/-! ## The polynomial coordinates of the core -/

/-- The Gauss–polynomial core, coordinatized by polynomials. -/
def coreEquiv : MvPolynomial (Fin d) ℂ ≃ₗ[ℂ] (polyGaussCore (d := d)) :=
  LinearEquiv.ofInjective (pgMap (d := d)) (pgMap_injective (d := d))

theorem coreEquiv_coe (p : MvPolynomial (Fin d) ℂ) :
    ((coreEquiv p : polyGaussCore (d := d)) : L2d d) = pgLp p := rfl

/-- An operator on the core, given by an operator on the polynomial coordinates. -/
def coreOp (T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :
    (polyGaussCore (d := d)) →ₗ[ℂ] (polyGaussCore (d := d)) :=
  (coreEquiv (d := d)).toLinearMap ∘ₗ T ∘ₗ (coreEquiv (d := d)).symm.toLinearMap





/-! ## The canonical pair: multiplication by `uᵢ` and `−i ∂/∂uᵢ` -/

/-- Multiplication by the coordinate, on polynomials. -/
def mulXPoly (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun p := X i * p
  map_add' p q := by rw [mul_add]
  map_smul' c p := by simp

/-- The momentum `−i ∂/∂uᵢ`, on polynomial coordinates. -/
def momPoly (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun p := C (-Complex.I) * (pderiv i p - C (1/2 : ℂ) * (X i * p))
  map_add' p q := by simp only [map_add, mul_add]; ring
  map_smul' c p := by
    simp only [RingHom.id_apply, MvPolynomial.smul_eq_C_mul, MvPolynomial.pderiv_C_mul]; ring



















/-! ## The unitary transport from the three-mode sequence space

The product Hermite functions indexed by `Vel = Fin 3 → ℕ` form a Hilbert basis of
`L²(ℝ³)`, so the sequence space `ℓ²(Vel)` of
`BookProof.ChapterNavierStokesThreeComponent` is unitarily `L²(du₁du₂du₃)`. -/























/-! ### The finite-mode core is spanned by its basis states -/









/-! ### The ladder action on the basis states -/







/-! ### The transport of the core, and of the ladder operators -/





















/-! ### The algebra of intertwined operators -/



















/-! ### Position and momentum as ladder combinations -/





/-! ### The transported canonical pair -/









/-! ### The differentially written Navier–Stokes quadratic symbol -/

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)









/-! ## Essential self-adjointness of the differentially written operator -/









/-! ## The Navier–Stokes reading of the coefficients -/





end

end BookProof.NavierStokesFlow.DifferentialL2



/-!
# Unitary transport of the unbounded layer

`BookProof.ChapterUnboundedPosition` proves the whole unbounded package — dense
natural domain, symmetry, self-adjointness, and a strongly continuous unitary
group of which the operator is the generator — for *multiplication* operators on
`ℓ²(ℤ)`.  That is the concrete half of the spectral picture.  This module supplies
the abstract half: **all of it is invariant under a unitary change of Hilbert
space.**

For a unitary `W : H ≃ₗᵢ[ℂ] K` and a densely defined operator `A` on a domain
`D ⊆ H`, the transported operator is `W A W⁻¹` on `W(D)` (`transportDomain`,
`transportOp`), and each structural property moves across:

* `transportDomain_dense` — the transported domain is dense;
* `transportOp_symmetric` — symmetry;
* `transport_adjointDomain` / `transport_isSelfAdjointOn` — the adjoint domain is
  the image of the adjoint domain, so **self-adjointness** transports;
* `tendsto_transportUnitary` — strong continuity of the transported group;
* `tendsto_slope_transportUnitary` — **Stone's relation** `dV/dt|₀ = i(WAW⁻¹)`.

Combining the two halves, `IsSelfAdjointOn` and the full Stone package hold for
*every* operator unitarily equivalent to a lattice multiplication operator, on any
complex Hilbert space:
`transported_position_isSelfAdjointOn`, `transported_position_group`,
`tendsto_transported_position_unitary`, `tendsto_slope_transported_position`.

This is exactly the reduction the spectral theorem is used for: an unbounded
self-adjoint operator with a diagonalizing unitary inherits its group.  What is
still missing for a general Stone theorem is the *existence* of the diagonalizing
unitary, i.e. the spectral theorem for unbounded self-adjoint operators.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped InnerProductSpace

namespace BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

/-! ## Abstract vocabulary for a densely defined operator -/

/-- The **domain of the adjoint** of an operator `A` defined on the domain `D`:
the vectors `φ` for which `ψ ↦ ⟪Aψ, φ⟫` is represented by an inner product. -/
def adjointDomain (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Set H :=
  {phi | ∃ eta : H, ∀ psi : D, ⟪A psi, phi⟫_ℂ = ⟪(psi : H), eta⟫_ℂ}

/-- `A` is **symmetric** on its domain. -/
def IsSymmetricOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  ∀ psi phi : D, ⟪A psi, (phi : H)⟫_ℂ = ⟪(psi : H), A phi⟫_ℂ

/-- `A` is **self-adjoint** on its domain: the adjoint domain is not merely
contained in but *equal* to `D`. -/
def IsSelfAdjointOn (D : Submodule ℂ H) (A : D →ₗ[ℂ] H) : Prop :=
  adjointDomain D A = (D : Set H)





/-! ## Transporting the domain and the operator -/













/-! ## The structural properties transport -/









/-! ## The unitary group transports -/













/-! ## Consequence: everything unitarily equivalent to lattice multiplication -/

open BookProof.ChapterUnboundedPosition
open (L2Z) BookProof.ChapterContinuityUnitaryInfinite















end BookProof.ChapterUnitaryTransport



/-!
# The closure of an essentially self-adjoint operator: the Hashimoto/SIRK consequence

The abstract theory — the graph `opGraph`, its closure `clGraph`, the closed
extension `clExt`, the self-adjointness criterion and the Cayley transform —
lives in `BookProof.ChapterEsaClosureCore`, which depends only on
`BookProof.ChapterFarisLavineCore` and Mathlib.  This module adds the part that
talks to the Hashimoto/SIRK shift-invert algorithm of
`BookProof.ChapterHashimotoComplexShifts`.
-/

open Filter Topology

namespace BookProof.EsaClosure

open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.HashimotoShiftInvert
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

/-! ## The positive companion of `IsSelfAdjointExtension` -/

/-- A *positive* self-adjoint extension is in particular a self-adjoint extension. -/
theorem isSelfAdjointExtension_of_positive {D Dom : Submodule ℂ F} {H : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (h : IsPositiveSelfAdjointExtension H A) : IsSelfAdjointExtension H A :=
  ⟨h.1, h.2.1, h.2.2.2⟩

section Positive

variable [CompleteSpace F]



end Positive

/-! ## Part 5 — the Hashimoto/SIRK algorithm, with no positivity -/

section Hashimoto

variable [CompleteSpace F]



end Hashimoto

end BookProof.EsaClosure



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





end FormDom

/-! ## Part D — the Friedrichs extension theorem, with no boundedness -/

open FormDom

variable [CompleteSpace F]







/-! ### The classical statement: symmetric and *bounded below* -/





/-! ## Part E — the Hashimoto/SIRK limit selects the constructed extension -/

open Filter Topology





/-! ## Part F — the construction is not vacuous: a genuinely unbounded operator -/



end BookProof.FriedrichsExtension



/-!
# The hyperbolic operator with an indefinite quadratic potential

`BookProof.ChapterStrichartzWave` proves essential self-adjointness of every
constant-coefficient operator with a real symbol — in particular of the wave operator
`□ = −∂_t² + Δ_x` — on the Schwartz core of `L²(ℝ^{1+n})`, and
`BookProof.ChapterWaveUnboundedPotential` does the same for multiplication by a real
potential of temperate growth.  Both of those are *commuting* halves: the first is a pure
Fourier multiplier, the second a pure multiplication operator.
`BookProof.ChapterHarmonicOscillatorEsa` settles the prototypical **non-commuting** mixture
in the *elliptic* normalization, `−d²/dx² + x²/4` on `L²(ℝ)`.

What was recorded as open (`STRICHARTZ_WAVE_ESA.md`, `CONSOLIDATED_PLAN.md` §9.5 and the
Lean-specialist backlog item A1) is the non-commuting mixture in the **hyperbolic**
normalization: `□ + V` with `V` in the Faris–Lavine class (bounded above by a quadratic —
the sign that the sign warning of `STRICHARTZ_WAVE_ESA.md` singles out; with the opposite
sign the operator genuinely fails to be essentially self-adjoint).  This module proves that
mixture for the quadratic potentials that are diagonal in the coordinates, by exhibiting
the joint eigenbasis: the product Hermite functions of
`BookProof.ChapterHermiteProductBasis`.

## What is proved

For an arbitrary real weight vector `c : Fin d → ℝ` — *no sign condition* — let

`H_c = ∑ᵢ cᵢ (−∂²/∂xᵢ² + xᵢ²/4)`

on the Gauss–polynomial (product Hermite) core `polyGaussCore` of `L²(ℝᵈ)`.

* `oscPoly`, `oscPoly_apply`, `oscPoly_hermiteMv` — the one-coordinate oscillator
  `−∂ᵢ² + xᵢ²/4`, written with the *canonical pair* `momPoly i = −i∂ᵢ`,
  `mulXPoly i = xᵢ·` of `BookProof.ChapterNavierStokesDifferentialL2`, is the number
  operator `aᵢ†aᵢ + ½` on the product Hermite functions;
* `quadOp`, `quadSymbol`, `quadOp_hermiteMvLp` — `H_c` on the core, and its diagonal
  action `H_c ψ_α = (∑ᵢ cᵢ(αᵢ + ½)) ψ_α`;
* `quadPoly_apply_eq_differential` — the **identification**: pointwise, `H_c` really is
  `∑ᵢ cᵢ(−∂ᵢ²f + (xᵢ²/4)f)` with Mathlib's `deriv` taken twice along the `i`-th coordinate
  line;
* `quadOp_symmetric` and `quadOp_essentiallySelfAdjoint` — **the headline**: `H_c` is
  symmetric and essentially self-adjoint on the Hermite core, for every real `c`;
* `quadOp_not_bounded`, `polyGaussCore_dense_L2'` — the operator is genuinely unbounded as
  soon as some `cᵢ ≠ 0`, and the core is dense, so the statement is not an artefact;
* `minkowskiCoeff`, `wave_indefiniteQuadratic_essentiallySelfAdjoint` and
  `minkowski_apply_eq_differential` — the case `c = (1, −1, …, −1)`: in the convention
  `□ = −∂_t² + Δ_x` of `BookProof.ChapterStrichartzWave` this is

  `□ + V`,  `V(t, x) = (t² − ‖x‖²)/4`,

  an unbounded potential which is bounded above by the quadratic `(t² + ‖x‖²)/4` — the
  Faris–Lavine sign — and which does not commute with `□`.

* `quadOp_add_boundedPotential_essentiallySelfAdjoint` and
  `quadOp_add_realBoundedPotential_essentiallySelfAdjoint` — the potential class is
  widened by the already-proved Kato–Rellich theorem: `H_c + W` is still essentially
  self-adjoint on the same core for every real, essentially bounded `W`, so the
  potential may be any *diagonal quadratic plus bounded* real function.

Two general instruments are proved on the way and are reusable:
`symmetricOn_of_diagonal` and `deficiencyTrivialAt_of_diagonal` — an operator that is
diagonal with a *real* symbol on an orthonormal family spanning its domain is symmetric,
and its deficiency spaces at non-real points vanish as soon as the family is total.

## Honest boundary

The potential is quadratic and diagonal in the coordinates (`∑ᵢ cᵢxᵢ²/4`); a general
Faris–Lavine potential bounded above by a quadratic is *not* covered — the joint
eigenbasis is what makes the argument work, and it exists only for the diagonal quadratic
family.  Nothing here claims anything for the opposite sign (the `−d²/dx² − x⁴` class,
whose deficiency indices are non-zero).
-/

namespace BookProof.HyperbolicQuadratic

open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

/-! ## An instrument: operators that are diagonal on an orthonormal family -/

section Diagonal

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}





end Diagonal

variable {d : ℕ}

/-! ## The one-coordinate oscillator in the canonical pair -/













/-! ## The Hamiltonian `H_c = ∑ᵢ cᵢ(−∂ᵢ² + xᵢ²/4)` -/













/-! ## Symmetry and essential self-adjointness -/











/-! ## The operator is unbounded -/





/-! ## The differential identification -/













theorem pgFun_smul (r : ℂ) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (r • p) x = r * pgFun p x := by
  simp [pgFun, MvPolynomial.smul_eval]
  ring

theorem pgFun_add (p q : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (p + q) x = pgFun p x + pgFun q x := by
  simp [pgFun]
  ring









/-! ## A bounded perturbation of the potential (Kato–Rellich) -/





/-! ## The Minkowski case: `□ + V` with an indefinite quadratic potential -/







end

end BookProof.HyperbolicQuadratic



/-!
# The general Stone theorem, part VII: the generator of a unitary group

Given a weakly measurable one-parameter unitary group `U` on a *separable* Hilbert space we
already know (von Neumann's theorem, `ChapterStoneMeasurable`) that `U` is strongly
continuous.  Here we construct its **infinitesimal generator**

`A x = i (d/dt)|₀ U t x`,

defined on the domain of vectors whose orbit is differentiable at `0`, and prove that `A`
is a densely defined self-adjoint operator.
-/

open scoped InnerProductSpace
open Filter Topology MeasureTheory

namespace BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

/-- Differentiating a Hilbert-space valued curve inside an inner product. -/
theorem hasDerivAt_inner_right {f : ℝ → H} {f' : H} {t : ℝ} (y : H) (h : HasDerivAt f f' t) :
    HasDerivAt (fun s => ⟪y, f s⟫_ℂ) (⟪y, f'⟫_ℂ) t :=
  ((innerSL ℂ y).restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt t h

/-- Complex conjugation may be pushed through a derivative. -/
theorem hasDerivAt_conj {g : ℝ → ℂ} {g' : ℂ} {t : ℝ} (h : HasDerivAt g g' t) :
    HasDerivAt (fun s => (starRingEnd ℂ) (g s)) ((starRingEnd ℂ) g') t :=
  (Complex.conjCLE : ℂ →L[ℝ] ℂ).hasFDerivAt.comp_hasDerivAt t h

/-- A continuous linear map may be pushed through a derivative. -/
theorem hasDerivAt_clm {f : ℝ → H} {f' : H} {t : ℝ} (L : H →L[ℂ] H) (h : HasDerivAt f f' t) :
    HasDerivAt (fun s => L (f s)) (L f') t :=
  (L.restrictScalars ℝ).hasFDerivAt.comp_hasDerivAt t h

namespace WeakMeasurableUnitaryGroup

variable [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
variable (G : WeakMeasurableUnitaryGroup H)

/-! ## The domain and the generator -/

/-- The domain of the infinitesimal generator: the vectors whose orbit is differentiable. -/
def genDomain : Submodule ℂ H where
  carrier := {x : H | DifferentiableAt ℝ (fun t : ℝ => G.U t x) 0}
  add_mem' := by
    intro x y hx hy
    have h : (fun t : ℝ => G.U t (x + y)) = fun t : ℝ => G.U t x + G.U t y := by
      funext t; exact ContinuousLinearMap.map_add (G.U t) x y
    change DifferentiableAt ℝ (fun t : ℝ => G.U t (x + y)) 0
    rw [h]
    exact hx.add hy
  zero_mem' := by
    have h : (fun t : ℝ => G.U t (0 : H)) = fun _ : ℝ => (0 : H) := by
      funext t; exact ContinuousLinearMap.map_zero (G.U t)
    change DifferentiableAt ℝ (fun t : ℝ => G.U t (0 : H)) 0
    rw [h]
    exact differentiableAt_const _
  smul_mem' := by
    intro c x hx
    have h : (fun t : ℝ => G.U t (c • x)) = fun t : ℝ => c • G.U t x := by
      funext t; exact ContinuousLinearMap.map_smul (G.U t) c x
    change DifferentiableAt ℝ (fun t : ℝ => G.U t (c • x)) 0
    rw [h]
    exact hx.const_smul c

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem mem_genDomain_iff (x : H) :
    x ∈ G.genDomain ↔ DifferentiableAt ℝ (fun t : ℝ => G.U t x) 0 := Iff.rfl

/-- The **infinitesimal generator** `A = i d/dt|₀ U t`. -/
noncomputable def genOp : G.genDomain →ₗ[ℂ] H where
  toFun x := Complex.I • deriv (fun t : ℝ => G.U t (x : H)) 0
  map_add' := by
    intro x y
    have h : (fun t : ℝ => G.U t ((x + y : G.genDomain) : H))
        = fun t : ℝ => G.U t (x : H) + G.U t (y : H) := by
      funext t
      rw [Submodule.coe_add]
      exact ContinuousLinearMap.map_add (G.U t) _ _
    have hd : deriv (fun t : ℝ => G.U t (x : H) + G.U t (y : H)) 0
        = deriv (fun t : ℝ => G.U t (x : H)) 0 + deriv (fun t : ℝ => G.U t (y : H)) 0 :=
      (x.2.hasDerivAt.add y.2.hasDerivAt).deriv
    change Complex.I • deriv (fun t : ℝ => G.U t ((x + y : G.genDomain) : H)) 0 = _
    rw [h, hd, smul_add]
  map_smul' := by
    intro c x
    have h : (fun t : ℝ => G.U t ((c • x : G.genDomain) : H))
        = fun t : ℝ => c • G.U t (x : H) := by
      funext t
      rw [Submodule.coe_smul]
      exact ContinuousLinearMap.map_smul (G.U t) c _
    have hd : deriv (fun t : ℝ => c • G.U t (x : H)) 0
        = c • deriv (fun t : ℝ => G.U t (x : H)) 0 :=
      (x.2.hasDerivAt.const_smul c).deriv
    change Complex.I • deriv (fun t : ℝ => G.U t ((c • x : G.genDomain) : H)) 0 = _
    rw [h, hd]
    simp only [RingHom.id_apply]
    rw [smul_comm]

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem genOp_apply (x : G.genDomain) :
    G.genOp x = Complex.I • deriv (fun t : ℝ => G.U t (x : H)) 0 := rfl



omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem genOp_eq_of_hasDerivAt {x : G.genDomain} {y : H}
    (h : HasDerivAt (fun t : ℝ => G.U t (x : H)) ((-Complex.I) • y) 0) : G.genOp x = y := by
  rw [genOp_apply, h.deriv, smul_smul]
  simp

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
/-- The defining differential equation at `t = 0`. -/
theorem hasDerivAt_orbit_zero (x : G.genDomain) :
    HasDerivAt (fun t : ℝ => G.U t (x : H)) ((-Complex.I) • G.genOp x) 0 := by
  have h : DifferentiableAt ℝ (fun t : ℝ => G.U t (x : H)) 0 := x.2
  have := h.hasDerivAt
  rw [genOp_apply, smul_smul]
  simpa using this

/-! ## Invariance of the domain -/

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem apply_mem_genDomain (s : ℝ) (x : G.genDomain) : G.U s (x : H) ∈ G.genDomain := by
  have h : (fun t : ℝ => G.U t (G.U s (x : H))) = fun t : ℝ => G.U s (G.U t (x : H)) := by
    funext t
    rw [G.apply_apply, G.apply_apply, add_comm]
  rw [mem_genDomain_iff, h]
  exact (hasDerivAt_clm (G.U s) (G.hasDerivAt_orbit_zero x)).differentiableAt

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem genOp_apply_comm (s : ℝ) (x : G.genDomain) :
    G.genOp ⟨G.U s (x : H), G.apply_mem_genDomain s x⟩ = G.U s (G.genOp x) := by
  refine G.genOp_eq_of_hasDerivAt ?_
  have h : (fun t : ℝ => G.U t (G.U s (x : H))) = fun t : ℝ => G.U s (G.U t (x : H)) := by
    funext t
    rw [G.apply_apply, G.apply_apply, add_comm]
  rw [h]
  have := hasDerivAt_clm (G.U s) (G.hasDerivAt_orbit_zero x)
  simpa using this

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
/-- The Schrödinger equation at an arbitrary time. -/
theorem hasDerivAt_orbit (x : G.genDomain) (t : ℝ) :
    HasDerivAt (fun s : ℝ => G.U s (x : H)) ((-Complex.I) • G.U t (G.genOp x)) t := by
  have hz : HasDerivAt (fun u : ℝ => G.U t (G.U u (x : H)))
      ((-Complex.I) • G.U t (G.genOp x)) (t - t) := by
    have h0 := hasDerivAt_clm (G.U t) (G.hasDerivAt_orbit_zero x)
    rw [map_smul] at h0
    simpa using h0
  have hshift : HasDerivAt (fun s : ℝ => G.U t (G.U (s - t) (x : H)))
      ((-Complex.I) • G.U t (G.genOp x)) t := HasDerivAt.comp_sub_const t t hz
  refine hshift.congr_of_eventuallyEq ?_
  filter_upwards with s
  rw [G.apply_apply]
  ring_nf

/-! ## The averaged vectors lie in the domain -/

/-- The Bochner average `∫₀ᵃ U t x dt`. -/
noncomputable def bAvg (x : H) (a : ℝ) : H := ∫ t in (0 : ℝ)..a, G.U t x

theorem hasDerivAt_bAvg (x : H) (a : ℝ) :
    HasDerivAt (fun u : ℝ => G.bAvg x u) (G.U a x) a := by
  have hc : Continuous fun t : ℝ => G.U t x := G.continuous_apply x
  exact intervalIntegral.integral_hasDerivAt_right (hc.intervalIntegrable 0 a)
    (hc.stronglyMeasurableAtFilter _ _) hc.continuousAt

theorem apply_bAvg (s a : ℝ) (x : H) :
    G.U s (G.bAvg x a) = G.bAvg x (s + a) - G.bAvg x s := by
  have hc : Continuous fun t : ℝ => G.U t x := G.continuous_apply x
  have h1 : G.U s (G.bAvg x a) = ∫ t in (0 : ℝ)..a, G.U s (G.U t x) := by
    rw [bAvg]
    exact ((G.U s).intervalIntegral_comp_comm (hc.intervalIntegrable 0 a)).symm
  have h2 : (∫ t in (0 : ℝ)..a, G.U s (G.U t x)) = ∫ t in (0 : ℝ)..a, G.U (s + t) x := by
    congr 1
    funext t
    rw [G.apply_apply]
  have h3 : (∫ t in (0 : ℝ)..a, G.U (s + t) x) = ∫ u in (s + 0)..(s + a), G.U u x :=
    intervalIntegral.integral_comp_add_left (f := fun u => G.U u x) (a := (0 : ℝ)) (b := a) s
  rw [h1, h2, h3, add_zero, bAvg, bAvg]
  exact (intervalIntegral.integral_interval_sub_left (hc.intervalIntegrable 0 (s + a))
    (hc.intervalIntegrable 0 s)).symm

theorem bAvg_mem_genDomain (x : H) (a : ℝ) : G.bAvg x a ∈ G.genDomain := by
  have h : (fun s : ℝ => G.U s (G.bAvg x a))
      = fun s : ℝ => G.bAvg x (s + a) - G.bAvg x s := by
    funext s; exact G.apply_bAvg s a x
  rw [mem_genDomain_iff, h]
  have hfa : HasDerivAt (fun u : ℝ => G.bAvg x u) (G.U a x) (0 + a) := by
    simpa using G.hasDerivAt_bAvg x a
  have h1 : HasDerivAt (fun s : ℝ => G.bAvg x (s + a)) (G.U a x) 0 :=
    HasDerivAt.comp_add_const 0 a hfa
  have h2 : HasDerivAt (fun s : ℝ => G.bAvg x s) (G.U 0 x) 0 := G.hasDerivAt_bAvg x 0
  exact (h1.sub h2).differentiableAt



/-! ## Density of the domain -/

theorem norm_bAvg_sub_smul_le (x : H) (a C : ℝ)
    (hC : ∀ t ∈ Set.uIcc (0 : ℝ) a, ‖G.U t x - x‖ ≤ C) :
    ‖G.bAvg x a - (a : ℂ) • x‖ ≤ C * |a| := by
  have hc : Continuous fun t : ℝ => G.U t x := G.continuous_apply x
  have hconst : (∫ _t in (0 : ℝ)..a, x) = (a : ℂ) • x := by
    rw [intervalIntegral.integral_const]
    simp [Complex.coe_smul]
  have hsub : G.bAvg x a - (a : ℂ) • x = ∫ t in (0 : ℝ)..a, (G.U t x - x) := by
    rw [bAvg, ← hconst,
      intervalIntegral.integral_sub (hc.intervalIntegrable 0 a)
        (intervalIntegrable_const)]
  rw [hsub]
  have := intervalIntegral.norm_integral_le_of_norm_le_const
    (a := (0 : ℝ)) (b := a) (C := C) (f := fun t => G.U t x - x)
    (fun t ht => hC t (by simpa [Set.uIoc, Set.uIcc] using Set.Ioc_subset_Icc_self ht))
  simpa using this

theorem denseDomain : Dense ((G.genDomain : Submodule ℂ H) : Set H) := by
  refine Metric.dense_iff.mpr ?_
  intro x r hr
  obtain ⟨δ, hδ, hball⟩ : ∃ δ > 0, ∀ ⦃t : ℝ⦄, dist t 0 < δ → dist (G.U t x) x < r / 2 := by
    have h := Metric.tendsto_nhds.mp (G.tendsto_apply_zero x) (r / 2) (by linarith)
    rw [Metric.eventually_nhds_iff] at h
    obtain ⟨δ, hδ, hb⟩ := h
    exact ⟨δ, hδ, fun t ht => hb ht⟩
  set a : ℝ := δ / 2 with ha
  have ha0 : 0 < a := by positivity
  have haδ : a < δ := by rw [ha]; linarith
  have hbound : ∀ t ∈ Set.uIcc (0 : ℝ) a, ‖G.U t x - x‖ ≤ r / 2 := by
    intro t ht
    rw [Set.uIcc_of_le ha0.le] at ht
    have hdt : dist t 0 < δ := by
      rw [Real.dist_eq, sub_zero, abs_of_nonneg ht.1]
      exact lt_of_le_of_lt ht.2 haδ
    have := hball hdt
    rw [dist_eq_norm] at this
    exact this.le
  have hkey := G.norm_bAvg_sub_smul_le x a (r / 2) hbound
  have hne : (a : ℂ) ≠ 0 := by exact_mod_cast ha0.ne'
  refine ⟨((a : ℂ)⁻¹) • G.bAvg x a, ?_, Submodule.smul_mem _ _ (G.bAvg_mem_genDomain x a)⟩
  rw [Metric.mem_ball, dist_eq_norm]
  have heq : ((a : ℂ)⁻¹) • G.bAvg x a - x = ((a : ℂ)⁻¹) • (G.bAvg x a - (a : ℂ) • x) := by
    rw [smul_sub, smul_smul, inv_mul_cancel₀ hne, one_smul]
  rw [heq, norm_smul]
  have hn : ‖((a : ℂ)⁻¹)‖ = a⁻¹ := by
    rw [norm_inv, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ha0]
  rw [hn]
  calc a⁻¹ * ‖G.bAvg x a - (a : ℂ) • x‖ ≤ a⁻¹ * (r / 2 * a) := by
        have h := mul_le_mul_of_nonneg_left hkey (le_of_lt (inv_pos.mpr ha0))
        rwa [abs_of_pos ha0] at h
    _ = r / 2 := by field_simp
    _ < r := by linarith

/-! ## Symmetry -/

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
theorem symmetric : BookProof.ChapterUnitaryTransport.IsSymmetricOn G.genDomain G.genOp := by
  intro psi phi
  have hx := G.hasDerivAt_orbit_zero psi
  have hy := G.hasDerivAt_orbit_zero phi
  have hf : HasDerivAt (fun t : ℝ => ⟪(phi : H), G.U t (psi : H)⟫_ℂ)
      (⟪(phi : H), (-Complex.I) • G.genOp psi⟫_ℂ) 0 :=
    hasDerivAt_inner_right (phi : H) hx
  have hyneg : HasDerivAt (fun t : ℝ => G.U (-t) (phi : H))
      ((-1 : ℝ) • ((-Complex.I) • G.genOp phi)) 0 := by
    have h := HasDerivAt.scomp (0 : ℝ) (by simpa using hy) (hasDerivAt_neg (0 : ℝ))
    simpa [Function.comp_def] using h
  have hg : HasDerivAt (fun t : ℝ => ⟪(psi : H), G.U (-t) (phi : H)⟫_ℂ)
      (⟪(psi : H), (-1 : ℝ) • ((-Complex.I) • G.genOp phi)⟫_ℂ) 0 :=
    hasDerivAt_inner_right (psi : H) hyneg
  have hEq : (fun t : ℝ => (starRingEnd ℂ) ⟪(psi : H), G.U (-t) (phi : H)⟫_ℂ)
      = fun t : ℝ => ⟪(phi : H), G.U t (psi : H)⟫_ℂ := by
    funext t
    rw [inner_conj_symm]
    exact (G.inner_adjoint t (phi : H) (psi : H)).symm
  have hfg : HasDerivAt (fun t : ℝ => ⟪(phi : H), G.U t (psi : H)⟫_ℂ)
      ((starRingEnd ℂ) ⟪(psi : H), (-1 : ℝ) • ((-Complex.I) • G.genOp phi)⟫_ℂ) 0 :=
    hEq ▸ hasDerivAt_conj hg
  have hsm : ((-1 : ℝ) • ((-Complex.I) • G.genOp phi)) = Complex.I • G.genOp phi := by
    rw [← Complex.coe_smul, smul_smul]
    norm_num
  have h := hf.unique hfg
  rw [hsm, inner_smul_right, inner_smul_right, map_mul] at h
  have hIne : (-Complex.I) ≠ 0 := by simp
  have hconjI : (starRingEnd ℂ) Complex.I = -Complex.I := by simp
  rw [hconjI] at h
  have key : ⟪(phi : H), G.genOp psi⟫_ℂ
      = (starRingEnd ℂ) ⟪(psi : H), G.genOp phi⟫_ℂ := mul_left_cancel₀ hIne h
  rw [inner_conj_symm] at key
  rw [← inner_conj_symm (G.genOp psi) (phi : H), ← inner_conj_symm (psi : H) (G.genOp phi), key]

/-! ## Self-adjointness -/

omit [CompleteSpace H] [TopologicalSpace.SeparableSpace H] in
/-- Weak convergence together with the bound `‖v i‖ ≤ ‖w‖` forces strong convergence. -/
theorem tendsto_of_weak_of_norm_le {ι : Type*} {l : Filter ι} {v : ι → H} {w : H}
    {D : Set H} (hD : Dense D) (hbd : ∀ᶠ i in l, ‖v i‖ ≤ ‖w‖)
    (hweak : ∀ x ∈ D, Tendsto (fun i => ⟪x, v i⟫_ℂ) l (𝓝 (⟪x, w⟫_ℂ))) :
    Tendsto v l (𝓝 w) := by
  rw [Metric.tendsto_nhds]
  intro ε hε
  set δ : ℝ := ε / 3 with hδdef
  have hδ : 0 < δ := by positivity
  obtain ⟨x, hxD, hxw⟩ : ∃ x ∈ D, dist w x < δ :=
    Metric.mem_closure_iff.mp (hD w) δ hδ
  have hre : Tendsto (fun i => (⟪x, v i⟫_ℂ).re) l (𝓝 ((⟪x, w⟫_ℂ).re)) :=
    (Complex.continuous_re.tendsto _).comp (hweak x hxD)
  have hev : ∀ᶠ i in l, (⟪x, w⟫_ℂ).re - δ ^ 2 / 2 < (⟪x, v i⟫_ℂ).re :=
    hre.eventually (eventually_gt_nhds (by nlinarith))
  filter_upwards [hbd, hev] with i hbi hei
  have hsq : ‖v i - x‖ ^ 2 = ‖v i‖ ^ 2 - 2 * (⟪v i, x⟫_ℂ).re + ‖x‖ ^ 2 := by
    simpa using norm_sub_sq (𝕜 := ℂ) (v i) x
  have hwsq : ‖w - x‖ ^ 2 = ‖w‖ ^ 2 - 2 * (⟪w, x⟫_ℂ).re + ‖x‖ ^ 2 := by
    simpa using norm_sub_sq (𝕜 := ℂ) w x
  have hswap1 : (⟪v i, x⟫_ℂ).re = (⟪x, v i⟫_ℂ).re := by
    rw [← inner_conj_symm (v i) x, Complex.conj_re]
  have hswap2 : (⟪w, x⟫_ℂ).re = (⟪x, w⟫_ℂ).re := by
    rw [← inner_conj_symm w x, Complex.conj_re]
  have hwx : ‖w - x‖ < δ := by rwa [← dist_eq_norm]
  have hwx2 : ‖w‖ ^ 2 - 2 * (⟪x, w⟫_ℂ).re + ‖x‖ ^ 2 < δ ^ 2 := by
    rw [← hswap2, ← hwsq]
    nlinarith [norm_nonneg (w - x)]
  have hlt : ‖v i - x‖ ^ 2 < (2 * δ) ^ 2 := by
    rw [hsq, hswap1]
    nlinarith [norm_nonneg (v i), norm_nonneg w]
  have hvx : ‖v i - x‖ < 2 * δ := by
    have h1 : (0 : ℝ) ≤ ‖v i - x‖ := norm_nonneg _
    nlinarith
  calc dist (v i) w ≤ ‖v i - x‖ + ‖x - w‖ := by
        rw [dist_eq_norm]
        simpa using norm_sub_le_norm_sub_add_norm_sub (v i) x w
    _ < 2 * δ + δ := by
        have : ‖x - w‖ < δ := by rw [norm_sub_rev, ← dist_eq_norm]; exact hxw
        linarith
    _ = ε := by rw [hδdef]; ring

/-! ## Self-adjointness -/

theorem selfAdjoint : BookProof.ChapterUnitaryTransport.IsSelfAdjointOn G.genDomain G.genOp := by
  refine Set.eq_of_subset_of_subset ?_ ?_
  · rintro phi ⟨eta, heta⟩
    -- the matrix coefficient `K u = ⟪φ, U u x⟫` and its derivative
    have hK : ∀ x : G.genDomain, ∀ s : ℝ,
        HasDerivAt (fun u : ℝ => ⟪phi, G.U u (x : H)⟫_ℂ)
          ((-Complex.I) * ⟪eta, G.U s (x : H)⟫_ℂ) s := by
      intro x s
      have h1 := hasDerivAt_inner_right phi (G.hasDerivAt_orbit x s)
      have h2 : ⟪phi, (-Complex.I) • G.U s (G.genOp x)⟫_ℂ
          = (-Complex.I) * ⟪eta, G.U s (x : H)⟫_ℂ := by
        rw [inner_smul_right]
        congr 1
        have hcomm := G.genOp_apply_comm s x
        have hz := heta ⟨G.U s (x : H), G.apply_mem_genDomain s x⟩
        rw [hcomm] at hz
        conv_lhs => rw [← inner_conj_symm]
        rw [hz, inner_conj_symm]
      rw [← h2]
      exact h1
    have hKbd : ∀ x : G.genDomain, ∀ s : ℝ,
        ‖(-Complex.I) * ⟪eta, G.U s (x : H)⟫_ℂ‖ ≤ ‖eta‖ * ‖(x : H)‖ := by
      intro x s
      rw [norm_mul, norm_neg, Complex.norm_I, one_mul]
      calc ‖⟪eta, G.U s (x : H)⟫_ℂ‖ ≤ ‖eta‖ * ‖G.U s (x : H)‖ := norm_inner_le_norm _ _
        _ = ‖eta‖ * ‖(x : H)‖ := by rw [G.norm_map]
    have hMVT : ∀ (x : G.genDomain) (t : ℝ),
        ‖⟪phi, G.U t (x : H)⟫_ℂ - ⟪phi, (x : H)⟫_ℂ‖ ≤ (‖eta‖ * ‖(x : H)‖) * |t| := by
      intro x t
      have h := (convex_univ (𝕜 := ℝ) (E := ℝ)).norm_image_sub_le_of_norm_hasDerivWithin_le
        (f := fun u : ℝ => ⟪phi, G.U u (x : H)⟫_ℂ)
        (f' := fun s : ℝ => (-Complex.I) * ⟪eta, G.U s (x : H)⟫_ℂ)
        (C := ‖eta‖ * ‖(x : H)‖)
        (fun s _ => (hK x s).hasDerivWithinAt) (fun s _ => hKbd x s)
        (Set.mem_univ (0 : ℝ)) (Set.mem_univ t)
      simpa using h
    -- the weak Lipschitz bound, first on the domain then everywhere
    have hconj : ∀ (t : ℝ) (x : H), ⟪x, G.U t phi - phi⟫_ℂ
        = (starRingEnd ℂ) (⟪phi, G.U (-t) x⟫_ℂ - ⟪phi, x⟫_ℂ) := by
      intro t x
      rw [map_sub, inner_conj_symm, inner_conj_symm, inner_sub_right]
      congr 1
      exact G.inner_adjoint t x phi
    have hb2 : ∀ (t : ℝ) (x : G.genDomain),
        ‖⟪(x : H), G.U t phi - phi⟫_ℂ‖ ≤ (|t| * ‖eta‖) * ‖(x : H)‖ := by
      intro t x
      rw [hconj t (x : H), RCLike.norm_conj]
      have := hMVT x (-t)
      rw [abs_neg] at this
      calc ‖⟪phi, G.U (-t) (x : H)⟫_ℂ - ⟪phi, (x : H)⟫_ℂ‖ ≤ (‖eta‖ * ‖(x : H)‖) * |t| := this
        _ = (|t| * ‖eta‖) * ‖(x : H)‖ := by ring
    have hb3 : ∀ (t : ℝ) (x : H),
        ‖⟪x, G.U t phi - phi⟫_ℂ‖ ≤ (|t| * ‖eta‖) * ‖x‖ := by
      intro t
      have hclosed : IsClosed
          {x : H | ‖⟪x, G.U t phi - phi⟫_ℂ‖ ≤ (|t| * ‖eta‖) * ‖x‖} :=
        isClosed_le ((continuous_id.inner continuous_const).norm)
          (continuous_const.mul continuous_norm)
      have hsub : ((G.genDomain : Submodule ℂ H) : Set H)
          ⊆ {x : H | ‖⟪x, G.U t phi - phi⟫_ℂ‖ ≤ (|t| * ‖eta‖) * ‖x‖} :=
        fun x hx => hb2 t ⟨x, hx⟩
      intro x
      have hall := hclosed.closure_subset_iff.mpr hsub
      rw [G.denseDomain.closure_eq] at hall
      exact hall (Set.mem_univ x)
    have hLip : ∀ t : ℝ, ‖G.U t phi - phi‖ ≤ |t| * ‖eta‖ := by
      intro t
      exact norm_le_of_inner_self_bound (by positivity) (hb3 t _)
    -- weak convergence of the difference quotients
    set w : H := (-Complex.I) • eta with hw
    have hweak : ∀ x ∈ ((G.genDomain : Submodule ℂ H) : Set H),
        Tendsto (fun t : ℝ => ⟪x, t⁻¹ • (G.U t phi - phi)⟫_ℂ) (𝓝[≠] (0 : ℝ))
          (𝓝 (⟪x, w⟫_ℂ)) := by
      intro x hx
      have hMd : HasDerivAt (fun u : ℝ => ⟪phi, G.U (-u) x⟫_ℂ)
          (Complex.I * ⟪eta, x⟫_ℂ) 0 := by
        have h0 := hK ⟨x, hx⟩ 0
        rw [G.apply_zero] at h0
        have h := HasDerivAt.scomp (0 : ℝ) (by simpa using h0) (hasDerivAt_neg (0 : ℝ))
        simp only [Function.comp_def] at h
        convert h using 1
        simp
      have hslope := hasDerivAt_iff_tendsto_slope.mp hMd
      have hcj : Tendsto
          (fun t : ℝ => (starRingEnd ℂ) (slope (fun u : ℝ => ⟪phi, G.U (-u) x⟫_ℂ) 0 t))
          (𝓝[≠] (0 : ℝ)) (𝓝 ((starRingEnd ℂ) (Complex.I * ⟪eta, x⟫_ℂ))) :=
        (Complex.continuous_conj.tendsto _).comp hslope
      have hfun : ∀ t : ℝ, ⟪x, t⁻¹ • (G.U t phi - phi)⟫_ℂ
          = (starRingEnd ℂ) (slope (fun u : ℝ => ⟪phi, G.U (-u) x⟫_ℂ) 0 t) := by
        intro t
        simp only [slope, vsub_eq_sub, sub_zero, neg_zero, G.apply_zero]
        rw [← Complex.coe_smul, inner_smul_right, hconj t x, ← Complex.coe_smul,
          smul_eq_mul, map_mul, Complex.conj_ofReal]
      have hlim : (starRingEnd ℂ) (Complex.I * ⟪eta, x⟫_ℂ) = ⟪x, w⟫_ℂ := by
        rw [hw, inner_smul_right, map_mul, inner_conj_symm]
        simp
      rw [← hlim]
      exact hcj.congr (fun t => (hfun t).symm)
    have hbdd : ∀ᶠ t : ℝ in 𝓝[≠] (0 : ℝ), ‖t⁻¹ • (G.U t phi - phi)‖ ≤ ‖w‖ := by
      filter_upwards [self_mem_nhdsWithin] with t ht
      have ht0 : t ≠ 0 := ht
      have hwn : ‖w‖ = ‖eta‖ := by
        rw [hw, norm_smul, norm_neg, Complex.norm_I, one_mul]
      rw [norm_smul, Real.norm_eq_abs, abs_inv, hwn]
      have habs : (0 : ℝ) < |t| := abs_pos.mpr ht0
      calc |t|⁻¹ * ‖G.U t phi - phi‖ ≤ |t|⁻¹ * (|t| * ‖eta‖) :=
            mul_le_mul_of_nonneg_left (hLip t) (by positivity)
        _ = ‖eta‖ := by field_simp
    have hstrong := tendsto_of_weak_of_norm_le G.denseDomain hbdd hweak
    have hderiv : HasDerivAt (fun t : ℝ => G.U t phi) w 0 := by
      rw [hasDerivAt_iff_tendsto_slope]
      exact hstrong.congr (fun t => by simp [slope, G.apply_zero])
    exact hderiv.differentiableAt
  · intro phi hphi
    exact ⟨G.genOp ⟨phi, hphi⟩, fun psi => G.symmetric psi ⟨phi, hphi⟩⟩





/-! ## Uniqueness: the group is the Stone group of its generator -/









end WeakMeasurableUnitaryGroup

end BookProof.ChapterStoneMeasurable



/-!
# The general Stone theorem, part I: resolvents of an unbounded self-adjoint operator

This module is the first of three that together prove **Stone's theorem in full
generality**: every densely defined self-adjoint operator `A` on a complex
Hilbert space generates a strongly continuous one-parameter unitary group
`t ↦ e^{-itA}`.

Here we build the analytic core: the **resolvents** `(A - i l)⁻¹` for real
`l ≠ 0`.

* `UnboundedSelfAdjoint` bundles a dense domain, the operator, symmetry and
  self-adjointness (in the sense of `BookProof.ChapterUnitaryTransport`).
* `UnboundedSelfAdjoint.closed_graph` — a self-adjoint operator is closed.
* `UnboundedSelfAdjoint.shift_bijective` — `A - i l` is a bijection from the
  domain onto the whole space (closed range with trivial orthogonal
  complement).
* `UnboundedSelfAdjoint.res` / `resCLM` — the resolvent as a linear map into the
  domain and as a bounded operator, with `‖(A - i l)⁻¹‖ ≤ 1/|l|`.
* `UnboundedSelfAdjoint.inner_res` — `((A - il)⁻¹)^* = (A + il)⁻¹`.
* `UnboundedSelfAdjoint.res_comm` — resolvents at different parameters commute.

Everything is `sorry`-free and `axiom`-free.
-/

open scoped InnerProductSpace
open Filter Topology

namespace BookProof.ChapterStoneResolvent

open BookProof.ChapterUnitaryTransport

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

/-- An **unbounded self-adjoint operator** on a complex Hilbert space: a dense
domain, a linear operator on it, symmetry, and equality of the adjoint domain
with the domain. -/
structure UnboundedSelfAdjoint (H : Type*) [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] where
  /-- The (dense) domain of definition. -/
  domain : Submodule ℂ H
  /-- The operator itself. -/
  op : domain →ₗ[ℂ] H
  /-- The domain is dense. -/
  denseDomain : Dense ((domain : Submodule ℂ H) : Set H)
  /-- The operator is symmetric. -/
  symmetric : IsSymmetricOn domain op
  /-- The adjoint domain is exactly the domain. -/
  selfAdjoint : IsSelfAdjointOn domain op

namespace UnboundedSelfAdjoint

variable (T : UnboundedSelfAdjoint H)

/-! ## Consequences of self-adjointness -/

/-- If `ψ ↦ ⟪Aψ, φ⟫` is represented by `η`, then `φ` lies in the domain. -/
theorem mem_domain_of_inner {phi eta : H}
    (h : ∀ psi : T.domain, ⟪T.op psi, phi⟫_ℂ = ⟪(psi : H), eta⟫_ℂ) :
    phi ∈ T.domain := by
  have hmem : phi ∈ adjointDomain T.domain T.op := ⟨eta, h⟩
  rw [T.selfAdjoint] at hmem
  exact hmem

/-- ... and then the representing vector is `A φ`. -/
theorem op_eq_of_inner {phi eta : H} (hphi : phi ∈ T.domain)
    (h : ∀ psi : T.domain, ⟪T.op psi, phi⟫_ℂ = ⟪(psi : H), eta⟫_ℂ) :
    T.op ⟨phi, hphi⟩ = eta := by
  have key : ∀ psi : T.domain, ⟪eta - T.op ⟨phi, hphi⟩, (psi : H)⟫_ℂ = 0 := by
    intro psi
    have h1 := h psi
    have h2 := T.symmetric psi ⟨phi, hphi⟩
    have h3 : ⟪(psi : H), eta - T.op ⟨phi, hphi⟩⟫_ℂ = 0 := by
      rw [inner_sub_right, ← h1, h2]
      simp
    rwa [inner_eq_zero_symm] at h3
  have h0 := T.denseDomain.eq_zero_of_inner_left (x := eta - T.op ⟨phi, hphi⟩) key
  exact (sub_eq_zero.mp h0).symm

/-- A self-adjoint operator is **closed**: its graph is closed. -/
theorem closed_graph {xs : ℕ → T.domain} {x y : H}
    (h1 : Tendsto (fun n => ((xs n : H))) atTop (𝓝 x))
    (h2 : Tendsto (fun n => T.op (xs n)) atTop (𝓝 y)) :
    ∃ h : x ∈ T.domain, T.op ⟨x, h⟩ = y := by
  have key : ∀ psi : T.domain, ⟪T.op psi, x⟫_ℂ = ⟪(psi : H), y⟫_ℂ := by
    intro psi
    have ha : Tendsto (fun n => ⟪T.op psi, ((xs n : H))⟫_ℂ) atTop (𝓝 ⟪T.op psi, x⟫_ℂ) :=
      (tendsto_const_nhds.inner h1 : _)
    have hb : Tendsto (fun n => ⟪(psi : H), T.op (xs n)⟫_ℂ) atTop (𝓝 ⟪(psi : H), y⟫_ℂ) :=
      (tendsto_const_nhds.inner h2 : _)
    have hab : (fun n => ⟪T.op psi, ((xs n : H))⟫_ℂ) = fun n => ⟪(psi : H), T.op (xs n)⟫_ℂ := by
      funext n
      exact T.symmetric psi (xs n)
    rw [hab] at ha
    exact tendsto_nhds_unique ha hb
  exact ⟨T.mem_domain_of_inner key, T.op_eq_of_inner _ key⟩

/-! ## The shifted operator `A - i l` -/

/-- The shifted operator `A - i l` on the domain. -/
noncomputable def shift (l : ℝ) : T.domain →ₗ[ℂ] H :=
  T.op - ((l : ℂ) * Complex.I) • T.domain.subtype

theorem shift_apply (l : ℝ) (x : T.domain) :
    T.shift l x = T.op x - ((l : ℂ) * Complex.I) • (x : H) := rfl

/-- `⟪Ax, x⟫` is real for a symmetric operator. -/
theorem inner_op_self_re (x : T.domain) :
    (⟪T.op x, (x : H)⟫_ℂ : ℂ) = ((RCLike.re ⟪T.op x, (x : H)⟫_ℂ : ℝ) : ℂ) := by
  have h := T.symmetric x x
  have h2 : ⟪(x : H), T.op x⟫_ℂ = starRingEnd ℂ ⟪T.op x, (x : H)⟫_ℂ := by
    rw [← inner_conj_symm]
  rw [h2] at h
  exact (Complex.conj_eq_iff_re.mp h.symm).symm

/-- The Pythagoras identity `‖(A - il)x‖² = ‖Ax‖² + l²‖x‖²`. -/
theorem norm_shift_sq (l : ℝ) (x : T.domain) :
    ‖T.shift l x‖ ^ 2 = ‖T.op x‖ ^ 2 + l ^ 2 * ‖(x : H)‖ ^ 2 := by
  have h1 : ‖T.op x - ((l : ℂ) * Complex.I) • (x : H)‖ ^ 2
      = ‖T.op x‖ ^ 2 - 2 * RCLike.re ⟪T.op x, ((l : ℂ) * Complex.I) • (x : H)⟫_ℂ
        + ‖((l : ℂ) * Complex.I) • (x : H)‖ ^ 2 := norm_sub_sq (𝕜 := ℂ) _ _
  have h2 : RCLike.re ⟪T.op x, ((l : ℂ) * Complex.I) • (x : H)⟫_ℂ = 0 := by
    rw [inner_smul_right, T.inner_op_self_re x]
    simp
  have h3 : ‖((l : ℂ) * Complex.I) • (x : H)‖ = |l| * ‖(x : H)‖ := by
    rw [norm_smul]
    simp
  rw [shift_apply, h1, h2, h3]
  rw [mul_pow, sq_abs]
  ring

theorem norm_shift_ge (l : ℝ) (x : T.domain) :
    |l| * ‖(x : H)‖ ≤ ‖T.shift l x‖ := by
  have h := T.norm_shift_sq l x
  nlinarith [norm_nonneg (T.shift l x), abs_nonneg l, norm_nonneg (x : H),
    sq_nonneg ‖T.op x‖, sq_abs l, mul_nonneg (abs_nonneg l) (norm_nonneg (x : H))]

theorem shift_injective {l : ℝ} (hl : l ≠ 0) : Function.Injective (T.shift l) := by
  intro a b hab
  have h : T.shift l (a - b) = 0 := by rw [map_sub, hab, sub_self]
  have h2 := T.norm_shift_ge l (a - b)
  rw [h] at h2
  have h3 : ‖((a : H) - (b : H))‖ ≤ 0 := by
    have habs : (0 : ℝ) < |l| := abs_pos.mpr hl
    have hco : ((a - b : T.domain) : H) = (a : H) - (b : H) := rfl
    have h4 : |l| * ‖(a : H) - (b : H)‖ ≤ 0 := by
      rw [← hco]; simpa using h2
    nlinarith [norm_nonneg ((a : H) - (b : H))]
  have : ((a : H)) = (b : H) := by
    have := le_antisymm h3 (norm_nonneg _)
    rwa [norm_sub_eq_zero_iff] at this
  exact Subtype.ext this

end UnboundedSelfAdjoint

variable [CompleteSpace H]

namespace UnboundedSelfAdjoint

variable (T : UnboundedSelfAdjoint H)

theorem shift_range_isClosed {l : ℝ} (hl : l ≠ 0) :
    IsClosed ((LinearMap.range (T.shift l) : Submodule ℂ H) : Set H) := by
  apply IsSeqClosed.isClosed
  intro ys z hys hz
  choose xs hxs using fun n => LinearMap.mem_range.mp (hys n)
  have habs : (0 : ℝ) < |l| := abs_pos.mpr hl
  have hbound : ∀ m n : ℕ, |l| * ‖((xs m : H)) - ((xs n : H))‖ ≤ ‖ys m - ys n‖ := by
    intro m n
    have h := T.norm_shift_ge l (xs m - xs n)
    rw [map_sub, hxs m, hxs n] at h
    simpa using h
  have hCauchy : CauchySeq (fun n => ((xs n : H))) := by
    rw [Metric.cauchySeq_iff]
    intro ε hε
    have hys' : CauchySeq ys := hz.cauchySeq
    rw [Metric.cauchySeq_iff] at hys'
    obtain ⟨N, hN⟩ := hys' (ε * |l|) (by positivity)
    refine ⟨N, fun m hm n hn => ?_⟩
    have h1 := hN m hm n hn
    rw [dist_eq_norm] at h1 ⊢
    have h2 := hbound m n
    nlinarith [norm_nonneg (((xs m : H)) - ((xs n : H)))]
  obtain ⟨x, hx⟩ := cauchySeq_tendsto_of_complete hCauchy
  have hop : Tendsto (fun n => T.op (xs n)) atTop (𝓝 (z + ((l : ℂ) * Complex.I) • x)) := by
    have : ∀ n, T.op (xs n) = ys n + ((l : ℂ) * Complex.I) • ((xs n : H)) := by
      intro n
      have := hxs n
      rw [shift_apply] at this
      rw [← this]
      abel
    simp only [this]
    exact hz.add ((tendsto_const_nhds).smul hx)
  obtain ⟨hmem, hval⟩ := T.closed_graph hx hop
  refine LinearMap.mem_range.mpr ⟨⟨x, hmem⟩, ?_⟩
  rw [shift_apply, hval]
  abel

omit [CompleteSpace H] in
theorem shift_range_orthogonal {l : ℝ} (hl : l ≠ 0) :
    (LinearMap.range (T.shift l))ᗮ = ⊥ := by
  rw [Submodule.eq_bot_iff]
  intro phi hphi
  rw [Submodule.mem_orthogonal] at hphi
  have key : ∀ psi : T.domain,
      ⟪T.op psi, phi⟫_ℂ = ⟪(psi : H), (-((l : ℂ) * Complex.I)) • phi⟫_ℂ := by
    intro psi
    have h0 := hphi (T.shift l psi) (LinearMap.mem_range_self _ _)
    rw [shift_apply, inner_sub_left, sub_eq_zero] at h0
    rw [h0, inner_smul_left, inner_smul_right]
    simp [Complex.conj_I]
  have hmem := T.mem_domain_of_inner key
  have hop := T.op_eq_of_inner hmem key
  have h1 := T.norm_shift_sq l ⟨phi, hmem⟩
  rw [shift_apply, hop] at h1
  have hlhs : ‖(-((l : ℂ) * Complex.I)) • phi - ((l : ℂ) * Complex.I) • phi‖
      = 2 * |l| * ‖phi‖ := by
    have : (-((l : ℂ) * Complex.I)) • phi - ((l : ℂ) * Complex.I) • phi
        = ((-2 : ℂ) * ((l : ℂ) * Complex.I)) • phi := by
      module
    rw [this, norm_smul]
    simp [mul_assoc]
  have hrhs : ‖(-((l : ℂ) * Complex.I)) • phi‖ = |l| * ‖phi‖ := by
    rw [norm_smul]; simp
  rw [hlhs, hrhs] at h1
  have hco : ‖((⟨phi, hmem⟩ : T.domain) : H)‖ = ‖phi‖ := rfl
  rw [hco] at h1
  have hphi0 : ‖phi‖ = 0 := by
    have habs : (0 : ℝ) < |l| := abs_pos.mpr hl
    have hkey : |l| ^ 2 * ‖phi‖ ^ 2 = l ^ 2 * ‖phi‖ ^ 2 := by rw [sq_abs]
    have hX : l ^ 2 * ‖phi‖ ^ 2 = 0 := by nlinarith [h1, hkey]
    have hl2 : (0 : ℝ) < l ^ 2 := by nlinarith [sq_abs l]
    have hN : ‖phi‖ ^ 2 = 0 := by
      rcases mul_eq_zero.mp hX with h | h
      · exact absurd h (ne_of_gt hl2)
      · exact h
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp hN
  simpa using hphi0

theorem shift_surjective {l : ℝ} (hl : l ≠ 0) : Function.Surjective (T.shift l) := by
  have hclosed := T.shift_range_isClosed hl
  haveI : CompleteSpace (LinearMap.range (T.shift l)) := hclosed.completeSpace_coe
  haveI := Submodule.HasOrthogonalProjection.ofCompleteSpace (LinearMap.range (T.shift l))
  have htop : LinearMap.range (T.shift l) = ⊤ :=
    Submodule.orthogonal_eq_bot_iff.mp (T.shift_range_orthogonal hl)
  exact LinearMap.range_eq_top.mp htop

theorem shift_bijective {l : ℝ} (hl : l ≠ 0) : Function.Bijective (T.shift l) :=
  ⟨T.shift_injective hl, T.shift_surjective hl⟩

/-! ## The resolvent -/

/-- `A - i l` as a linear equivalence from the domain onto the space. -/
noncomputable def shiftEquiv {l : ℝ} (hl : l ≠ 0) : T.domain ≃ₗ[ℂ] H :=
  LinearEquiv.ofBijective (T.shift l) (T.shift_bijective hl)

























end UnboundedSelfAdjoint

end BookProof.ChapterStoneResolvent



/-!
# The BRST-reduced transfer: the unitary evolution descends to BRST cohomology

`CONSOLIDATED_PLAN.md` §10.6.2 item 4 asks, besides the concrete gauge-fixed field-space
Hamiltonian and its BRST charge, for the **BRST-reduced transfer** of the half-density
unitary `U`: the evolution *must map the physical subspace to itself* and must descend to
the physical states modulo the exact (gauge) ones, which is the caveat recorded in §10.3.
This module proves exactly that, for an arbitrary bounded nilpotent BRST charge `Ω` and an
arbitrary strongly-commuting unitary group — in particular for the group `e^{-itT}` that
the project's Stone theorem produces from an unbounded self-adjoint Hamiltonian.

## What is proved

Write `physicalStates Ω = ker Ω` (the BRST-closed states) and
`exactStates Ω = closure (range Ω)` (the BRST-exact, i.e. pure-gauge, states; the closure
is what makes the quotient a topological object).  Nilpotency `Ω² = 0` gives
`exactStates_le_physicalStates`, so the **BRST cohomology**
`Cohomology Ω = physicalStates Ω ⧸ exactStates Ω` is defined.

* `physicalStates_invariant` / `exactStates_invariant` — a bounded operator commuting with
  `Ω` maps closed states to closed states and exact states to exact states.  The second
  needs the closure argument: continuity carries `range Ω` into `closure (range Ω)`.
* `reducedMap` — the induced ℂ-linear map on cohomology, with `reducedMap_mk` describing it
  on classes.
* For a one-parameter family `U` commuting with `Ω`: **`transfer`**, with
  `transfer_zero`, `transfer_comp` (the group law `transfer s ∘ transfer t = transfer (s+t)`)
  and `transfer_bijective` — so the reduced transfer is a one-parameter group of linear
  automorphisms of the cohomology.
* **`infDist_exactStates_eq`** — when the `U t` are isometries, the distance to the exact
  states, i.e. the quotient (BRST) norm of the class, is preserved:
  `infDist (U t x) (exactStates Ω) = infDist x (exactStates Ω)`.  The reduced transfer is
  therefore norm-preserving on cohomology, not merely well defined.
* The Stone instance `stoneTransfer` with `stoneTransfer_zero`, `stoneTransfer_comp`,
  `stoneTransfer_bijective` and `infDist_exactStates_stoneU_eq`: the unitary group of an
  unbounded self-adjoint Hamiltonian commuting with `Ω` descends to a one-parameter group
  of norm-preserving automorphisms of the BRST cohomology.

## Honest boundary

`Ω` is a *bounded* nilpotent operator and is assumed to commute with the group (the correct
unbounded form of `[H, Ω] = 0`); the concrete 3D gauge-fixed field-space Hamiltonian and its
ghost-sector BRST charge of §10.6.2 item 4 are not constructed here — this module supplies
the reduction statement that such a construction must feed.
-/

namespace BookProof.BrstReducedTransfer

open BookProof BookProof.ChapterStoneResolvent

section General

variable {H : Type*} [NormedAddCommGroup H] [NormedSpace ℂ H]

variable (Om : H →L[ℂ] H)

/-- The BRST-closed (physical) states: the kernel of the BRST charge. -/
def physicalStates : Submodule ℂ H := LinearMap.ker (Om : H →ₗ[ℂ] H)

/-- The BRST-exact (pure gauge) states: the closure of the range of the BRST charge.  The
closure is what makes the quotient by them a well-behaved topological object. -/
def exactStates : Submodule ℂ H := (LinearMap.range (Om : H →ₗ[ℂ] H)).topologicalClosure



theorem mem_exactStates_of_apply (y : H) : Om y ∈ exactStates Om :=
  Submodule.le_topologicalClosure _ ⟨y, rfl⟩

theorem isClosed_exactStates : IsClosed (exactStates Om : Set H) :=
  Submodule.isClosed_topologicalClosure _



variable {Om}

/-- A bounded operator commuting with the BRST charge preserves the physical subspace. -/
theorem physicalStates_invariant {f : H →L[ℂ] H} (h : ∀ y, f (Om y) = Om (f y)) :
    ∀ x ∈ physicalStates Om, f x ∈ physicalStates Om := by
  intro x hx
  have hx' : Om x = 0 := hx
  change Om (f x) = 0
  rw [← h x, hx', map_zero]

/-- A bounded operator commuting with the BRST charge preserves the exact (gauge) states.
Continuity is what carries the range into its closure. -/
theorem exactStates_invariant {f : H →L[ℂ] H} (h : ∀ y, f (Om y) = Om (f y)) :
    ∀ x ∈ exactStates Om, f x ∈ exactStates Om := by
  intro x hx
  have hcl : IsClosed (f ⁻¹' (exactStates Om : Set H)) :=
    (isClosed_exactStates Om).preimage f.continuous
  have hsub : closure (LinearMap.range (Om : H →ₗ[ℂ] H) : Set H)
      ⊆ f ⁻¹' (exactStates Om : Set H) := by
    refine closure_minimal ?_ hcl
    rintro z ⟨y, rfl⟩
    have : f (Om y) ∈ exactStates Om := by
      rw [h y]; exact mem_exactStates_of_apply Om (f y)
    exact this
  exact hsub (by simpa [exactStates, Submodule.topologicalClosure_coe] using hx)

variable (Om)

/-- The exact states, seen inside the physical subspace. -/
def trivialSub : Submodule ℂ (physicalStates Om) :=
  (exactStates Om).comap (physicalStates Om).subtype

/-- **BRST cohomology**: physical (closed) states modulo exact (pure gauge) ones. -/
abbrev Cohomology := physicalStates Om ⧸ trivialSub Om

/-- The map induced on BRST cohomology by an operator preserving the closed and the exact
states. -/
def reducedMap (f : H →L[ℂ] H) (hp : ∀ x ∈ physicalStates Om, f x ∈ physicalStates Om)
    (he : ∀ x ∈ exactStates Om, f x ∈ exactStates Om) :
    Cohomology Om →ₗ[ℂ] Cohomology Om :=
  Submodule.mapQ _ _ ((f : H →ₗ[ℂ] H).restrict hp) fun _ hx => he _ hx



section Group

variable (U : ℝ → (H →L[ℂ] H)) (hcomm : ∀ (t : ℝ) (y : H), U t (Om y) = Om (U t y))

/-- **The BRST-reduced transfer.**  A one-parameter family commuting with the BRST charge
descends to BRST cohomology. -/
def transfer (t : ℝ) : Cohomology Om →ₗ[ℂ] Cohomology Om :=
  reducedMap Om (U t) (physicalStates_invariant (hcomm t)) (exactStates_invariant (hcomm t))













end Group

end General

section Stone

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H) (Om : H →L[ℂ] H)
variable (hcomm : ∀ (t : ℝ) (y : H), T.stoneU t (Om y) = Om (T.stoneU t y))















end Stone

end BookProof.BrstReducedTransfer



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

variable [CompleteSpace F]











/-! ## Part 3 — uniqueness -/





end SelfAdjoint

/-! ## Part 4 — the Cayley transform: the generator produces a unitary -/

section Cayley

variable [CompleteSpace F] {Dom : Submodule ℂ F}







end Cayley


end BookProof.EsaClosure



/-!
# The Stone bridge: from a selected self-adjoint extension to the unitary flow

`BookProof.ChapterStoneResolvent`–`BookProof.ChapterStoneTheorem` prove Stone's
theorem in full generality, but they consume the *bundled* structure
`UnboundedSelfAdjoint` (a dense domain, the operator, symmetry, and equality of
the adjoint domain with the domain).  The essential-self-adjointness /
Hashimoto-selection threads (Navier–Stokes, Yang–Mills) instead produce the
predicates `BookProof.EsaClosure.IsSelfAdjointExtension` and
`BookProof.YangMillsFriedrichs.IsPositiveSelfAdjointExtension` for an operator
`A : Dom →ₗ[ℂ] F`.

This module is the missing packaging step, plus the resulting flow statement:

* `dense_domain_of_isSelfAdjointExtension` — a self-adjoint extension of a
  densely defined operator has a dense domain;
* `isSelfAdjointOn_of_isSelfAdjointExtension` — the adjoint domain of such an
  extension is *equal* to its domain (both inclusions are conjuncts of the
  predicate, one via symmetry and one via the representation clause);
* `unboundedSelfAdjointOf` — the bundled `UnboundedSelfAdjoint` structure built
  from `IsSelfAdjointExtension`, with `unboundedSelfAdjointOf_domain` /
  `unboundedSelfAdjointOf_op`;
* `IsStoneFlow` — the flow package: `U 0 = 1`, the group law, isometry of each
  `U t`, and the Schrödinger equation `d/dt U t x = -i A (U t x)` on the domain;
* `isStoneFlow_stoneU` — Stone's group `e^{-itA}` is such a flow;
* `exists_stone_flow_of_selfAdjointExtension`, `exists_stone_flow_of_positive`
  and `exists_stone_flow_of_esa` — the three entry points: from a selected
  self-adjoint extension, from a positive (Friedrichs) one, and directly from
  essential self-adjointness of a symmetric core operator.

Everything is `sorry`-free and `axiom`-free.
-/

open Filter Topology
open scoped InnerProductSpace

namespace BookProof.StoneBridge

open BookProof.FarisLavine BookProof.EsaClosure BookProof.YangMillsFriedrichs
open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-! ## Packaging a selected extension -/













/-! ## The flow package -/

/-- **A Stone flow for `T`**: a one-parameter family `U` of operators with
`U 0 = 1`, the group law, every `U t` isometric, and solving the Schrödinger
equation `d/dt (U t x) = -i T (U t x)` on the domain of `T` (in particular the
orbit of a domain vector stays in the domain). -/
def IsStoneFlow (T : UnboundedSelfAdjoint F) (U : ℝ → (F →L[ℂ] F)) : Prop :=
  U 0 = 1 ∧ (∀ s t, U (s + t) = U s * U t) ∧ (∀ t x, ‖U t x‖ = ‖x‖) ∧
    ∀ (x : F) (_hx : x ∈ T.domain) (t : ℝ), ∃ h : U t x ∈ T.domain,
      HasDerivAt (fun s : ℝ => U s x) ((-Complex.I) • T.op ⟨U t x, h⟩) t

variable [CompleteSpace F]









end BookProof.StoneBridge



/-!
# The general Stone theorem, part VI: weak measurability implies strong continuity

This module contains the *converse* half of Stone's theorem in the separable setting.
A **weakly measurable one-parameter unitary group** is a family `U t` of unitaries with
`U 0 = 1`, `U (s + t) = U s U t` and such that `t ↦ ⟪y, U t x⟫` is measurable for all
`x y`.

Von Neumann's theorem states that on a *separable* Hilbert space every such group is
automatically strongly continuous.  The proof averages the group over an interval,
`x_a = ∫₀ᵃ U t x dt` (defined weakly, through the Riesz representation), observes the
quantitative estimate `‖U s x_a - x_a‖ ≤ 2 |s| ‖x‖`, and shows that the vectors `x_a`
span a dense subspace — this is the step that uses separability.
-/

open scoped InnerProductSpace
open Filter Topology MeasureTheory

namespace BookProof.ChapterStoneMeasurable

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

/-- If `‖⟪y, y⟫‖ ≤ C ‖y‖` with `C ≥ 0`, then `‖y‖ ≤ C`. -/
theorem norm_le_of_inner_self_bound {y : H} {C : ℝ} (hC : 0 ≤ C)
    (h : ‖⟪y, y⟫_ℂ‖ ≤ C * ‖y‖) : ‖y‖ ≤ C := by
  have hn : ‖⟪y, y⟫_ℂ‖ = ‖y‖ * ‖y‖ := by
    rw [inner_self_eq_norm_sq_to_K]
    simp [sq]
  rw [hn] at h
  rcases eq_or_lt_of_le (norm_nonneg y) with h0 | h0
  · rw [← h0]; exact hC
  · exact le_of_mul_le_mul_right (by linarith) h0

/-- A **weakly measurable one-parameter unitary group** on a complex Hilbert space. -/
structure WeakMeasurableUnitaryGroup (H : Type*) [NormedAddCommGroup H]
    [InnerProductSpace ℂ H] where
  /-- The family of operators. -/
  U : ℝ → (H →L[ℂ] H)
  /-- The value at `0` is the identity. -/
  map_zero : U 0 = 1
  /-- The one-parameter group law. -/
  map_add : ∀ s t, U (s + t) = U s * U t
  /-- Every `U t` is isometric. -/
  norm_map : ∀ t x, ‖U t x‖ = ‖x‖
  /-- Weak measurability. -/
  weaklyMeasurable : ∀ x y : H, Measurable fun t => ⟪ y, U t x ⟫_ℂ

namespace WeakMeasurableUnitaryGroup

variable (G : WeakMeasurableUnitaryGroup H)

/-- Each `U t` is a linear isometry. -/
noncomputable def isom (t : ℝ) : H →ₗᵢ[ℂ] H :=
  ⟨(G.U t : H →ₗ[ℂ] H), G.norm_map t⟩

theorem inner_map_map (t : ℝ) (x y : H) : ⟪ G.U t x, G.U t y ⟫_ℂ = ⟪ x, y ⟫_ℂ :=
  (G.isom t).inner_map_map x y

theorem apply_apply (s t : ℝ) (x : H) : G.U s (G.U t x) = G.U (s + t) x := by
  rw [G.map_add]; rfl

@[simp] theorem apply_zero (x : H) : G.U 0 x = x := by rw [G.map_zero]; rfl

theorem surjective (t : ℝ) : Function.Surjective (G.U t) := by
  intro y
  refine ⟨G.U (-t) y, ?_⟩
  rw [G.apply_apply]
  simp



theorem norm_inner_le (t : ℝ) (x y : H) : ‖⟪ y, G.U t x ⟫_ℂ‖ ≤ ‖y‖ * ‖x‖ := by
  calc ‖⟪ y, G.U t x ⟫_ℂ‖ ≤ ‖y‖ * ‖G.U t x‖ := norm_inner_le_norm _ _
    _ = ‖y‖ * ‖x‖ := by rw [G.norm_map]

/-! ## Interval integrability of the matrix coefficients -/

theorem intervalIntegrable_inner (x y : H) (a b : ℝ) :
    IntervalIntegrable (fun t => ⟪ y, G.U t x ⟫_ℂ) volume a b := by
  rw [intervalIntegrable_iff]
  refine Measure.integrableOn_of_bounded (M := ‖y‖ * ‖x‖) ?_ ?_ ?_
  · exact (measure_Ioc_lt_top).ne
  · exact ((G.weaklyMeasurable x y).stronglyMeasurable).aestronglyMeasurable
  · exact Eventually.of_forall (fun t => G.norm_inner_le t x y)

/-! ## The averaged vectors `x_a = ∫₀ᵃ U t x dt` -/

/-- The linear functional `y ↦ conj ∫₀ᵃ ⟪y, U t x⟫ dt`. -/
noncomputable def avgFunctional (x : H) (a : ℝ) : H →L[ℂ] ℂ :=
  LinearMap.mkContinuous
    { toFun := fun y => starRingEnd ℂ (∫ t in (0 : ℝ)..a, ⟪ y, G.U t x ⟫_ℂ)
      map_add' := by
        intro y z
        rw [← RingHom.map_add]
        congr 1
        rw [← intervalIntegral.integral_add (G.intervalIntegrable_inner x y 0 a)
          (G.intervalIntegrable_inner x z 0 a)]
        congr 1
        funext t
        rw [inner_add_left]
      map_smul' := by
        intro c y
        simp only [RingHom.id_apply]
        have h : (fun t => ⟪ c • y, G.U t x ⟫_ℂ)
            = fun t => (starRingEnd ℂ) c * ⟪ y, G.U t x ⟫_ℂ := by
          funext t
          rw [inner_smul_left]
        rw [h, intervalIntegral.integral_const_mul, map_mul]
        simp }
    (|a| * ‖x‖) (by
      intro y
      simp only [LinearMap.coe_mk, AddHom.coe_mk, RCLike.norm_conj]
      have hbound : ‖∫ t in (0 : ℝ)..a, ⟪ y, G.U t x ⟫_ℂ‖ ≤ (‖y‖ * ‖x‖) * |a - 0| := by
        refine intervalIntegral.norm_integral_le_of_norm_le_const ?_
        intro t _
        exact G.norm_inner_le t x y
      calc ‖∫ t in (0 : ℝ)..a, ⟪ y, G.U t x ⟫_ℂ‖ ≤ (‖y‖ * ‖x‖) * |a - 0| := hbound
        _ = |a| * ‖x‖ * ‖y‖ := by rw [sub_zero]; ring)

/-- The averaged vector `x_a = ∫₀ᵃ U t x dt`, defined weakly. -/
noncomputable def avgVec [CompleteSpace H] (x : H) (a : ℝ) : H :=
  (InnerProductSpace.toDual ℂ H).symm (G.avgFunctional x a)

theorem inner_avgVec [CompleteSpace H] (x : H) (a : ℝ) (y : H) :
    ⟪ y, G.avgVec x a ⟫_ℂ = ∫ t in (0 : ℝ)..a, ⟪ y, G.U t x ⟫_ℂ := by
  have h : ⟪ G.avgVec x a, y ⟫_ℂ = G.avgFunctional x a y := by
    rw [avgVec, ← InnerProductSpace.toDual_apply_apply (𝕜 := ℂ)]
    simp
  rw [← inner_conj_symm, h]
  simp [avgFunctional]

/-! ## The estimate `‖U s x_a - x_a‖ ≤ 2 |s| ‖x‖` -/

/-- `U s` may be moved across the inner product, becoming `U (-s)`. -/
theorem inner_adjoint (s : ℝ) (y v : H) : ⟪ y, G.U s v ⟫_ℂ = ⟪ G.U (-s) y, v ⟫_ℂ := by
  have h := G.inner_map_map s (G.U (-s) y) v
  rw [G.apply_apply] at h
  simp only [add_neg_cancel, G.apply_zero] at h
  exact h

theorem inner_apply_avgVec [CompleteSpace H] (s a : ℝ) (x y : H) :
    ⟪ y, G.U s (G.avgVec x a) ⟫_ℂ = ∫ t in s..(s + a), ⟪ y, G.U t x ⟫_ℂ := by
  rw [G.inner_adjoint, G.inner_avgVec]
  have h : (fun t => ⟪ G.U (-s) y, G.U t x ⟫_ℂ) = fun t => ⟪ y, G.U (s + t) x ⟫_ℂ := by
    funext t
    rw [← G.apply_apply s t x]
    exact (G.inner_adjoint s y (G.U t x)).symm
  rw [h]
  have hc := intervalIntegral.integral_comp_add_left
    (f := fun u => ⟪ y, G.U u x ⟫_ℂ) (a := (0 : ℝ)) (b := a) s
  simpa using hc

theorem norm_inner_apply_avgVec_sub_le [CompleteSpace H] (s a : ℝ) (x y : H) :
    ‖⟪ y, G.U s (G.avgVec x a) - G.avgVec x a ⟫_ℂ‖ ≤ 2 * |s| * ‖x‖ * ‖y‖ := by
  rw [inner_sub_right, G.inner_apply_avgVec, G.inner_avgVec]
  have hint : ∀ p q : ℝ, IntervalIntegrable (fun u => ⟪ y, G.U u x ⟫_ℂ) volume p q :=
    fun p q => G.intervalIntegrable_inner x y p q
  have h1 : ((∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ) + ∫ t in s..(s + a), ⟪ y, G.U t x ⟫_ℂ)
      = ∫ t in (0:ℝ)..(s + a), ⟪ y, G.U t x ⟫_ℂ :=
    intervalIntegral.integral_add_adjacent_intervals (hint 0 s) (hint s (s + a))
  have h2 : ((∫ t in (0:ℝ)..a, ⟪ y, G.U t x ⟫_ℂ) + ∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ)
      = ∫ t in (0:ℝ)..(s + a), ⟪ y, G.U t x ⟫_ℂ :=
    intervalIntegral.integral_add_adjacent_intervals (hint 0 a) (hint a (s + a))
  have hsplit : ((∫ t in s..(s + a), ⟪ y, G.U t x ⟫_ℂ) - ∫ t in (0:ℝ)..a, ⟪ y, G.U t x ⟫_ℂ)
      = (∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ) - ∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ := by
    linear_combination h1 - h2
  rw [hsplit]
  have hb1 : ‖∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ‖ ≤ (‖y‖ * ‖x‖) * |s| := by
    have := intervalIntegral.norm_integral_le_of_norm_le_const
      (a := a) (b := s + a) (C := ‖y‖ * ‖x‖) (f := fun u => ⟪ y, G.U u x ⟫_ℂ)
      (fun t _ => G.norm_inner_le t x y)
    simpa using this
  have hb2 : ‖∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ‖ ≤ (‖y‖ * ‖x‖) * |s| := by
    have := intervalIntegral.norm_integral_le_of_norm_le_const
      (a := (0:ℝ)) (b := s) (C := ‖y‖ * ‖x‖) (f := fun u => ⟪ y, G.U u x ⟫_ℂ)
      (fun t _ => G.norm_inner_le t x y)
    simpa using this
  calc ‖(∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ) - ∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ‖
      ≤ ‖∫ t in a..(s + a), ⟪ y, G.U t x ⟫_ℂ‖ + ‖∫ t in (0:ℝ)..s, ⟪ y, G.U t x ⟫_ℂ‖ :=
        norm_sub_le _ _
    _ ≤ (‖y‖ * ‖x‖) * |s| + (‖y‖ * ‖x‖) * |s| := add_le_add hb1 hb2
    _ = 2 * |s| * ‖x‖ * ‖y‖ := by ring

/-- **The key quantitative estimate.**  The averaged vector `x_a = ∫₀ᵃ U t x dt` is moved
only a little by `U s`. -/
theorem norm_apply_avgVec_sub_le [CompleteSpace H] (s a : ℝ) (x : H) :
    ‖G.U s (G.avgVec x a) - G.avgVec x a‖ ≤ 2 * |s| * ‖x‖ := by
  refine norm_le_of_inner_self_bound (by positivity) ?_
  exact G.norm_inner_apply_avgVec_sub_le s a x _

theorem tendsto_apply_avgVec [CompleteSpace H] (x : H) (a : ℝ) :
    Tendsto (fun s : ℝ => G.U s (G.avgVec x a)) (𝓝 0) (𝓝 (G.avgVec x a)) := by
  rw [tendsto_iff_norm_sub_tendsto_zero]
  have hbd : Tendsto (fun s : ℝ => 2 * |s| * ‖x‖) (𝓝 0) (𝓝 0) := by
    have hcont : Continuous (fun s : ℝ => 2 * |s| * ‖x‖) := by fun_prop
    simpa using hcont.tendsto 0
  exact squeeze_zero (fun s => norm_nonneg _) (fun s => G.norm_apply_avgVec_sub_le s a x) hbd

/-! ## The set of strong-continuity vectors -/

/-- The submodule of vectors at which the group is strongly continuous at `0`. -/
def contSubmodule : Submodule ℂ H where
  carrier := {v : H | Tendsto (fun s : ℝ => G.U s v) (𝓝 0) (𝓝 v)}
  add_mem' := by
    intro v w hv hw
    have h : (fun s : ℝ => G.U s (v + w)) = fun s : ℝ => G.U s v + G.U s w := by
      funext s; exact ContinuousLinearMap.map_add (G.U s) v w
    change Tendsto (fun s : ℝ => G.U s (v + w)) (𝓝 0) (𝓝 (v + w))
    rw [h]
    exact hv.add hw
  zero_mem' := by
    have h : (fun s : ℝ => G.U s (0 : H)) = fun _ : ℝ => (0 : H) := by
      funext s; exact ContinuousLinearMap.map_zero (G.U s)
    change Tendsto (fun s : ℝ => G.U s (0 : H)) (𝓝 0) (𝓝 (0 : H))
    rw [h]
    exact tendsto_const_nhds
  smul_mem' := by
    intro c v hv
    have h : (fun s : ℝ => G.U s (c • v)) = fun s : ℝ => c • G.U s v := by
      funext s; exact ContinuousLinearMap.map_smul (G.U s) c v
    change Tendsto (fun s : ℝ => G.U s (c • v)) (𝓝 0) (𝓝 (c • v))
    rw [h]
    exact hv.const_smul c



/-! ## The span of the averaged vectors -/

/-- The set of all averaged vectors `∫₀ᵃ U t x dt`. -/
def avgSet [CompleteSpace H] : Set H := {v : H | ∃ (x : H) (a : ℝ), v = G.avgVec x a}

/-- The linear span of the averaged vectors. -/
def avgSpan [CompleteSpace H] : Submodule ℂ H := Submodule.span ℂ G.avgSet

theorem avgSpan_le_contSubmodule [CompleteSpace H] : G.avgSpan ≤ G.contSubmodule := by
  refine Submodule.span_le.mpr ?_
  rintro v ⟨x, a, rfl⟩
  exact G.tendsto_apply_avgVec x a

/-! ## Separability: the averaged vectors span a dense subspace -/

/-- A bounded measurable real function is locally integrable. -/
theorem locallyIntegrable_of_bounded {f : ℝ → ℝ} (hm : Measurable f) {M : ℝ}
    (hb : ∀ t, ‖f t‖ ≤ M) : LocallyIntegrable f volume := by
  rw [locallyIntegrable_iff]
  intro k hk
  exact Measure.integrableOn_of_bounded (M := M) hk.measure_lt_top.ne
    hm.aestronglyMeasurable (Eventually.of_forall hb)

/-- If all the averages `∫₀ᵃ ⟪z, U t x⟫ dt` vanish, then `⟪z, U t x⟫ = 0` for almost every `t`.
This is the Lebesgue differentiation theorem applied to the real and imaginary parts. -/
theorem ae_inner_eq_zero (z x : H)
    (h : ∀ a : ℝ, (∫ t in (0:ℝ)..a, ⟪ z, G.U t x ⟫_ℂ) = 0) :
    ∀ᵐ t : ℝ, ⟪ z, G.U t x ⟫_ℂ = 0 := by
  have hmeas : Measurable fun t => ⟪ z, G.U t x ⟫_ℂ := G.weaklyMeasurable x z
  have hbd : ∀ t, ‖⟪ z, G.U t x ⟫_ℂ‖ ≤ ‖z‖ * ‖x‖ := fun t => G.norm_inner_le t x z
  have hre : LocallyIntegrable (fun t => (⟪ z, G.U t x ⟫_ℂ).re) volume :=
    locallyIntegrable_of_bounded (M := ‖z‖ * ‖x‖) hmeas.re
      (fun t => le_trans (by simpa using RCLike.norm_re_le_norm (K := ℂ) _) (hbd t))
  have him : LocallyIntegrable (fun t => (⟪ z, G.U t x ⟫_ℂ).im) volume :=
    locallyIntegrable_of_bounded (M := ‖z‖ * ‖x‖) hmeas.im
      (fun t => le_trans (by simpa using RCLike.norm_im_le_norm (K := ℂ) _) (hbd t))
  have hzre : ∀ a : ℝ, (∫ t in (0:ℝ)..a, (⟪ z, G.U t x ⟫_ℂ).re) = 0 := by
    intro a
    have := Complex.reCLM.intervalIntegral_comp_comm (G.intervalIntegrable_inner x z 0 a)
    simpa [h a] using this
  have hzim : ∀ a : ℝ, (∫ t in (0:ℝ)..a, (⟪ z, G.U t x ⟫_ℂ).im) = 0 := by
    intro a
    have := Complex.imCLM.intervalIntegral_comp_comm (G.intervalIntegrable_inner x z 0 a)
    simpa [h a] using this
  filter_upwards [LocallyIntegrable.ae_hasDerivAt_integral hre,
    LocallyIntegrable.ae_hasDerivAt_integral him] with t hrt hit
  have h1 := hrt 0
  have h2 := hit 0
  rw [funext hzre] at h1
  rw [funext hzim] at h2
  have e1 : (⟪ z, G.U t x ⟫_ℂ).re = 0 :=
    ((hasDerivAt_const t (0:ℝ)).unique h1).symm
  have e2 : (⟪ z, G.U t x ⟫_ℂ).im = 0 :=
    ((hasDerivAt_const t (0:ℝ)).unique h2).symm
  exact Complex.ext e1 e2

/-- **Separability step.**  On a separable Hilbert space the averaged vectors span a
dense subspace. -/
theorem avgSpan_orthogonal_eq_bot [CompleteSpace H] [TopologicalSpace.SeparableSpace H] :
    G.avgSpanᗮ = ⊥ := by
  rw [Submodule.eq_bot_iff]
  intro z hz
  have hzero : ∀ (x : H) (a : ℝ), (∫ t in (0:ℝ)..a, ⟪ z, G.U t x ⟫_ℂ) = 0 := by
    intro x a
    have hmem : G.avgVec x a ∈ G.avgSpan :=
      Submodule.subset_span ⟨x, a, rfl⟩
    have := hz _ hmem
    rw [← G.inner_avgVec x a z, ← inner_conj_symm]
    simpa using congrArg (starRingEnd ℂ) this
  obtain ⟨D, hDcount, hDdense⟩ := TopologicalSpace.exists_countable_dense H
  have hDc : Countable D := hDcount.to_subtype
  have hae : ∀ᵐ t : ℝ, ∀ x : D, ⟪ z, G.U t (x : H) ⟫_ℂ = 0 :=
    ae_all_iff.mpr (fun x => G.ae_inner_eq_zero z (x : H) (hzero (x : H)))
  obtain ⟨t₀, ht₀⟩ := hae.exists
  have hcont : Continuous fun w : H => ⟪ z, G.U t₀ w ⟫_ℂ :=
    continuous_const.inner (G.U t₀).continuous
  have hall : ∀ w : H, ⟪ z, G.U t₀ w ⟫_ℂ = 0 := by
    have := Continuous.ext_on hDdense hcont continuous_const
      (fun w hw => ht₀ ⟨w, hw⟩)
    exact fun w => congrFun this w
  obtain ⟨w, hw⟩ := G.surjective t₀ z
  have := hall w
  rw [hw] at this
  exact inner_self_eq_zero.mp this

theorem dense_avgSpan [CompleteSpace H] [TopologicalSpace.SeparableSpace H] :
    Dense (G.avgSpan : Set H) := by
  have h : G.avgSpan.topologicalClosure = ⊤ :=
    Submodule.topologicalClosure_eq_top_iff.mpr G.avgSpan_orthogonal_eq_bot
  rw [dense_iff_closure_eq]
  have := congrArg (fun K : Submodule ℂ H => (K : Set H)) h
  simpa [Submodule.topologicalClosure] using this

/-! ## Von Neumann's theorem: weak measurability implies strong continuity -/

/-- **Von Neumann's theorem.**  A weakly measurable one-parameter unitary group on a
separable Hilbert space is strongly continuous at `0`. -/
theorem tendsto_apply_zero [CompleteSpace H] [TopologicalSpace.SeparableSpace H] (x : H) :
    Tendsto (fun s : ℝ => G.U s x) (𝓝 0) (𝓝 x) := by
  rw [Metric.tendsto_nhds]
  intro ε hε
  obtain ⟨v, hv, hvx⟩ : ∃ v ∈ (G.avgSpan : Set H), dist x v < ε / 3 := by
    have hx : x ∈ closure (G.avgSpan : Set H) := G.dense_avgSpan x
    exact (Metric.mem_closure_iff.mp hx) (ε / 3) (by linarith)
  have hvc : Tendsto (fun s : ℝ => G.U s v) (𝓝 0) (𝓝 v) :=
    G.avgSpan_le_contSubmodule hv
  filter_upwards [Metric.tendsto_nhds.mp hvc (ε / 3) (by linarith)] with s hs
  have h1 : dist (G.U s x) (G.U s v) = dist x v := by
    rw [dist_eq_norm, dist_eq_norm, ← map_sub]
    exact G.norm_map s _
  have h2 : dist v x = dist x v := dist_comm v x
  calc dist (G.U s x) x ≤ dist (G.U s x) (G.U s v) + dist (G.U s v) v + dist v x :=
        dist_triangle4 _ _ _ _
    _ < ε / 3 + ε / 3 + ε / 3 := by rw [h1, h2]; linarith
    _ = ε := by ring

/-- **Von Neumann's theorem**, global form: the orbits are continuous. -/
theorem continuous_apply [CompleteSpace H] [TopologicalSpace.SeparableSpace H] (x : H) :
    Continuous fun t : ℝ => G.U t x := by
  refine continuous_iff_continuousAt.mpr fun t₀ => ?_
  have hshift : Tendsto (fun s : ℝ => G.U t₀ (G.U s x)) (𝓝 0) (𝓝 (G.U t₀ x)) :=
    ((G.U t₀).continuous.tendsto x).comp (G.tendsto_apply_zero x)
  have hcomp : Tendsto (fun t : ℝ => t - t₀) (𝓝 t₀) (𝓝 0) := by
    have : Tendsto (fun t : ℝ => t - t₀) (𝓝 t₀) (𝓝 (t₀ - t₀)) :=
      (continuous_id.sub continuous_const).tendsto t₀
    simpa using this
  have := hshift.comp hcomp
  refine this.congr fun t => ?_
  simp only [Function.comp_apply]
  rw [G.apply_apply]
  ring_nf

end WeakMeasurableUnitaryGroup

end BookProof.ChapterStoneMeasurable



/-!
# The gauge-fixed Yang–Mills Hamiltonian on the Gauss–polynomial core of `L²(ℝ⁹⁹)`

`PLAN_LEAN_SPECIALIST_QYM_FLOW.md` Part F asks for the **field-space** (option
(b)) realization of the Weyl-gauge Yang–Mills Hamiltonian: the fields must act as
genuine multiplication and differentiation operators on a dense core of
`L²(ℝ⁹⁹)`, not merely abstractly on an occupation-number space.

The core is `BookProof.HermiteProductCore.polyGaussCore`, the span of the product
Hermite functions `p(x) e^{-‖x‖²/4}`.  Because the map `p ↦ p · e^{-‖x‖²/4}` is
an injective linear map from `ℂ[X₀,…,X₉₈]`, every operator can be defined at the
purely algebraic level of polynomials and transported to the core (`CoreRep`).

* `mulOp f` — multiplication by a polynomial (F.2, the coordinate operators
  `A_{k,a}`);
* `derOp j`, `momOp j` — the true derivative `∂_j` of `p·e^{-‖x‖²/4}` written back
  on the polynomial factor, and the momentum `π_j = −i ∂_j` (F.3);
* `magPoly i a` — the magnetic field
  `B_{i a} = ε_{ijk}(∂_j A_{k,a} + f_{abc} A_{j,b} A_{k,c})`, a *real* polynomial
  in the `99 = 3 + 24 + 72` coordinates (3 spatial, 24 fields `A_{j,a}`, 72
  independent derivative coordinates `∂_j A_{k,a}`), acting by multiplication
  (F.4);
* `weylProd` — the Weyl ordering `½(PQ + QP)`, symmetric whenever `P` and `Q`
  are (F.5); the canonical commutation relation `[A_{j}, π_{j}] = i` is
  `commutator_coord_mom`;
* `ymHamiltonian` — `H₁ = ½ Σ π² + ½ Σ B²`, the *positive* sum of squares (the
  sign of `book.tex:7077` reconciled), well defined, symmetric and positive on
  the core (F.6–F.8);
* `ym_hermite_friedrichs_extension` (F.9) and `ym_hermite_hashimoto_selects`
  (F.10) — the instantiation of the already-proved
  `BookProof.FriedrichsExtension.friedrichs_extension_exists` and
  `BookProof.FriedrichsExtension.weyl_hashimoto_selects_friedrichs`.

Nothing here claims a mass gap or global existence; the Millennium problem stays
out of scope.
-/

namespace BookProof.YangMillsHermite

open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension BookProof.HashimotoShiftInvert

noncomputable section

variable {d : ℕ}

/-! ## Conjugate polynomials and the inner product on the core -/

/-- Complex conjugation of the coefficients of a polynomial. -/
def starP (p : MvPolynomial (Fin d) ℂ) : MvPolynomial (Fin d) ℂ := map (starRingEnd ℂ) p





























/-- Conjugation of the coefficients is conjugation of the values at real points. -/
theorem eval_starP (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (starP p)
      = (starRingEnd ℂ) (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p) := by
  rw [starP, eval_map]
  induction p using MvPolynomial.induction_on with
  | C a => simp
  | add p q hp hq => simp [hp, hq]
  | mul_X p i hp => simp [hp]

/-- **The inner product of two core vectors is a Gaussian polynomial integral.** -/
theorem inner_pgLp_pgLp (p q : MvPolynomial (Fin d) ℂ) :
    (inner ℂ (pgLp p) (pgLp q) : ℂ) = gaussInt (starP p * q) := by
  rw [inner_pgLp, gaussInt]
  refine integral_congr_ae ?_
  filter_upwards [pgLp_coeFn q] with x hx
  have hev : MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (starP p * q)
      = (starRingEnd ℂ) (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p)
        * MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q := by
    rw [map_mul, eval_starP]
  rw [hx, hev, pgFun, pgFun, gaussWD_eq_sq]
  simp only [map_mul, Complex.conj_ofReal]
  push_cast
  ring

/-! ## Polynomial-level operators and Gauss symmetry -/

/-- A polynomial-level operator is **Gauss symmetric** when it is symmetric for
the Gaussian inner product `⟪p, q⟫ = ∫ p̄ q e^{-‖x‖²/2}`.  By
`inner_pgLp_pgLp` this is exactly symmetry of the transported operator on the
core. -/
def PolySym (T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) : Prop :=
  ∀ p q : MvPolynomial (Fin d) ℂ, gaussInt (starP (T p) * q) = gaussInt (starP p * T q)











/-- **Weyl ordering** `½(PQ + QP)`: the symmetric product of two operators.
This is the ordering prescription for the non-commuting `πA` cross terms. -/
def weylProd (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    Module.End ℂ (MvPolynomial (Fin d) ℂ) :=
  ((1 / 2 : ℝ) : ℂ) • (S.comp T + T.comp S)



/-! ### Multiplication operators (F.2) -/

/-- Multiplication by a fixed polynomial. -/
def mulOp (f : MvPolynomial (Fin d) ℂ) : Module.End ℂ (MvPolynomial (Fin d) ℂ) :=
  LinearMap.mulLeft ℂ f





/-! ### Momentum operators (F.3) -/


























/-! ## Transport to the Gauss–polynomial core of `L²(ℝᵈ)` -/



section Transport

variable {D : Submodule ℂ (L2d d)}



















end Transport

section YangMills

variable {D : Submodule ℂ (L2d 99)}

/-! ## The Yang–Mills coordinates of `ℝ⁹⁹`

`99 = 3 + 24 + 72`: three spatial coordinates `x_i`, the `24 = 3 × 8` gauge-field
coordinates `A_{j,a}` (`j` spatial, `a` an `SU(3)` colour index), and the
`72 = 3 × 3 × 8` coordinates `∂_j A_{k,a}`, which in the book's parametrization
are independent coordinates of the configuration space. -/



















/-! ## The Hamiltonian on the core (F.6–F.8) -/



















/-! ## Instantiation of the Friedrichs and Hashimoto theorems (F.9, F.10) -/







end YangMills


end

end BookProof.YangMillsHermite



/-!
# Second quantization over a one-particle core (Part F.11)

`PLAN_LEAN_SPECIALIST_QYM_FLOW.md` Part F.11 asks for the **second-quantized**
Hamiltonian on the finite-occupation states over the one-particle core, i.e. the
last row of the field-space realization of the gauge-fixed Yang–Mills
Hamiltonian.

The Fock space over a one-particle space with a countable orthonormal basis
`(e_k)` is `ℓ²` over the *configurations* `Conf = ℕ →₀ ℕ` (occupation numbers,
finitely many excited modes), and the finite-occupation domain is the dense
subspace `lpFiniteModes Conf` of finitely supported configuration vectors.  All
operators are defined at the *algebraic* level on `FockAlg = Conf →₀ ℂ` — where
linearity is free — and transported to the Hilbert space by the isomorphism
`fockEquiv`.

* `up`, `dn` — adding and removing one quantum in a mode;
* `annA j`, `creA j` — annihilation and creation, with the canonical commutation
  relation `[a_j, a_j†] = 1` (`ccr_annA_creA`) and the adjoint pairing
  `⟪a_j† u, v⟫ = ⟪u, a_j v⟫` (`inner_creA_left`);
* `dGamma col` — the second quantization `dΓ(A) = Σ_{j,k} ⟪e_j, A e_k⟫ a_j† a_k`
  of a one-particle operator given by its (column-finite) matrix `col`, and
  `dGamma_one_particle`, which checks that on the one-particle sector it *is*
  the one-particle operator;
* `dGammaOp_symmetricOn`, `dGammaOp_quadForm_nonneg` — symmetry and positivity of
  `dΓ(A)` on the finite-occupation domain, from Hermiticity and positivity of the
  one-particle matrix;
* `dGamma_friedrichs_extension` — hence `dΓ(A)` has a positive self-adjoint
  (Friedrichs) extension;
* `secondQuantization_friedrichs` — the same for the matrix of an arbitrary
  symmetric positive one-particle operator on the finite-mode domain of a Hilbert
  basis;
* `ym_fock_friedrichs_extension` — **F.11**: the second quantization of the
  field-space Yang–Mills Hamiltonian `H₁ = ½Σπ² + ½ΣB²` of
  `BookProof.YangMillsHermite` has a positive self-adjoint extension on the Fock
  space over the Gauss–polynomial core of `L²(ℝ⁹⁹)`;
* `dGamma_hashimoto_selects`, `secondQuantization_hashimoto_selects` and
  `ym_fock_hashimoto_selects` — the Hashimoto/SIRK shift-invert limit selects
  exactly that Friedrichs extension, with the Galerkin truncations of the
  shift-inverted operator converging strongly and in the resolvent sense.

No mass gap and no global existence is claimed; the Millennium problem stays out
of scope.
-/

namespace BookProof.FockSecondQuantization

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

/-! ## Configurations -/

/-- A **configuration**: the occupation numbers of the one-particle modes, all
but finitely many of them zero. -/
abbrev Conf := ℕ →₀ ℕ

/-- The **algebraic Fock space**: finite linear combinations of configurations. -/
abbrev FockAlg := Conf →₀ ℂ

/-- The **Fock space** `ℓ²(Conf)`. -/
abbrev Fock := L2I Conf

/-- Add one quantum in the mode `j`. -/
def up (j : ℕ) (α : Conf) : Conf := Finsupp.update α j (α j + 1)

/-- Remove one quantum from the mode `j` (nothing happens if the mode is
empty). -/
def dn (j : ℕ) (α : Conf) : Conf := Finsupp.update α j (α j - 1)

@[simp] theorem up_self (j : ℕ) (α : Conf) : up j α j = α j + 1 := by
  simp [up]

theorem up_of_ne {i j : ℕ} (α : Conf) (h : i ≠ j) : up j α i = α i := by
  simp [up, Finsupp.update_apply, h]

@[simp] theorem dn_self (j : ℕ) (α : Conf) : dn j α j = α j - 1 := by
  simp [dn]

theorem dn_of_ne {i j : ℕ} (α : Conf) (h : i ≠ j) : dn j α i = α i := by
  simp [dn, Finsupp.update_apply, h]

@[simp] theorem dn_up (j : ℕ) (α : Conf) : dn j (up j α) = α := by
  refine Finsupp.ext fun i => ?_
  by_cases h : i = j
  · subst h; simp
  · rw [dn_of_ne _ h, up_of_ne _ h]

theorem up_dn (j : ℕ) {α : Conf} (h : 1 ≤ α j) : up j (dn j α) = α := by
  refine Finsupp.ext fun i => ?_
  by_cases hi : i = j
  · subst hi; simp; omega
  · rw [up_of_ne _ hi, dn_of_ne _ hi]

theorem up_injective (j : ℕ) : Function.Injective (up j) := by
  intro α β h
  have := congrArg (dn j) h
  simpa using this





/-! ## Annihilation and creation at the algebraic level -/































/-- The set of modes excited by a state of the algebraic Fock space. -/
def modes (u : FockAlg) : Finset ℕ := u.support.biUnion Finsupp.support





/-! ## Transport to `ℓ²(Conf)` -/

/-- A finitely supported configuration vector as an element of `ℓ²(Conf)`. -/
def toLp (u : FockAlg) : Fock :=
  ⟨fun α => u α, memLpTwo_of_finite_support u.finite_support⟩

























/-! ## Second quantization -/

















/-! ### Symmetry and positivity -/



























/-! ### The second-quantized operator on the finite-occupation domain -/













/-! ## The matrix of a one-particle operator -/

section OneParticle

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]















end OneParticle

/-! ## The Hashimoto/SIRK selection for the second-quantized operator -/

section Selection

open Filter Topology

























end Selection

/-! ## The second-quantized Yang–Mills Hamiltonian (F.11) -/

section YangMills

open BookProof.YangMillsHermite BookProof.HermiteProductCore
open Filter Topology













end YangMills

end

end BookProof.FockSecondQuantization



/-!
# Relatively bounded (unbounded) perturbations of the diagonal quadratic Hamiltonian

`BookProof.ChapterHyperbolicQuadraticEsa` proves that
`H_c = ∑ᵢ cᵢ(−∂ᵢ² + xᵢ²/4)` is essentially self-adjoint on the Gauss–polynomial
(product Hermite) core of `L²(ℝᵈ)` for *every* real weight vector `c`, and widens the
potential class by a **bounded** real multiplier (Kato–Rellich).  This module widens it by
an **unbounded** perturbation, in the elliptic case `cᵢ ≥ c₀ > 0`:

* `posL`, `momL`, `oscL` — the position `xᵢ`, the momentum `πᵢ = −i∂ᵢ` and the
  one-coordinate oscillator `πᵢ² + xᵢ²/4`, as operators from the core into `L²`;
* `posL_symmetric`, `momL_symmetric` — both are symmetric on the core (Gaussian
  integration by parts, through `BookProof.YangMillsHermite.PolySym`);
* `inner_oscL_eq` — the form identity `⟪u, (πᵢ² + xᵢ²/4)u⟫ = ‖πᵢu‖² + ‖xᵢu‖²/4`;
* `re_inner_oscL_le_quadOp` — for weights `cᵢ ≥ c₀ > 0` the oscillator form of a single
  coordinate is dominated by the form of `H_c`: `c₀⟪u, oscᵢ u⟫ ≤ ⟪u, H_c u⟫` (the symbols
  satisfy `c₀(αᵢ + ½) ≤ ∑ⱼ cⱼ(αⱼ + ½)`);
* `norm_posL_le`, `norm_momL_le` — consequently `xᵢ` and `πᵢ` are `H_c`-bounded with
  *arbitrarily small* relative bound: `‖xᵢu‖ ≤ ε‖H_c u‖ + (2/(c₀ε))‖u‖`, and the same for
  `πᵢ`;
* HEADLINE `quadOp_add_firstOrder_essentiallySelfAdjoint` — therefore `H_c + B` is
  essentially self-adjoint on the same core for every **first-order** perturbation
  `B = ∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)` with real coefficients.  The perturbation is genuinely
  unbounded, so this is outside the reach of the bounded Kato–Rellich statement;
* `hermiteMvBasis_repr_quadOp` — the product Hermite basis *is* a diagonalizing unitary
  for `H_c`: in those coordinates the operator is multiplication by the real symbol
  `∑ᵢ cᵢ(αᵢ + ½)`;
* `harmonicOsc_add_linearPotential_essentiallySelfAdjoint` and
  `foOp_linear_apply_eq_mul` — the physical corollary: the Stark-shifted oscillator
  `−Δ + ‖x‖²/4 + ⟨b, x⟩` (a harmonic oscillator in a constant external field) is
  essentially self-adjoint on the Hermite core, the perturbation being multiplication by
  the unbounded real function `x ↦ ⟨b, x⟩`.

Two general instruments are proved on the way and are reusable: `apply_sum_of_diagonal`
and `re_inner_diagonal_le` — a diagonal operator with a real symbol acts on a finite
combination of the diagonalizing vectors coefficientwise, and the quadratic forms of two
diagonal operators are ordered by their symbols.

## Honest boundary

The strict positivity `cᵢ ≥ c₀ > 0` is used, and is not removable by this argument: in
the hyperbolic (mixed sign) case the symbol `∑ⱼ cⱼ(αⱼ + ½)` vanishes on an infinite set of
multi-indices, so `H_c` does not dominate the number operator and no relative bound of the
above kind can hold.  The general Faris–Lavine potential (bounded above by a quadratic)
therefore stays open, as recorded in `CONSOLIDATED_PLAN.md`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.HermiteRelative

open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section

/-! ## Instruments: diagonal operators on an orthonormal family -/

section Diagonal

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}







end Diagonal

variable {d : ℕ}

/-! ## The canonical pair and the one-coordinate oscillator on the core -/

















/-! ### Symmetry, by Gaussian integration by parts -/















/-! ### The oscillator form -/





/-! ### The diagonal action of the oscillator and of `H_c` -/





/-! ### The relative bounds -/











/-! ## The first-order perturbation -/

/-- The first-order symbol `∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)`, on polynomial coordinates. -/
def foPoly (b b' : Fin d → ℝ) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  ∑ i, (((b i : ℝ) : ℂ) • mulXPoly i + ((b' i : ℝ) : ℂ) • momPoly i)



















/-! ## The diagonalizing unitary -/



/-! ## The Stark-shifted oscillator -/





end

end BookProof.HermiteRelative



/-!
# The R + αR² (Starobinsky) potentials, and the flow of the regularized conformal mode

Plan item **A5** (`CONSOLIDATED_PLAN.md` §10.5), steps 1 and — at the mode level — 3/4.

The `f(R) = (M²/2)R + αR²` extension of the Einstein–Hilbert action is the one whose extra
term *regularizes* the conformal mode: the linear `−(M²/2)R_c` term, whose negative
conformal-mode gradient energy leaves pure general relativity unbounded below, is turned by
the positive `αR_c²` into a parabola bounded below by `−M⁴/(16α)`.

## What is proved

**1. The ghost-free scalar–tensor form.**  With `ψ = 1 + 4αR/M²` and
`U(ψ) = (M⁴/16α)(ψ − 1)²`, `fR_eq_scalarTensor` is the identity
`f(R) = (M²/2)ψR − U(ψ)`: `R + αR²` gravity is a *second-order* scalar–tensor theory.

**2. The Einstein-frame scalaron potential.**  `starobinskyV M α φ = (M⁴/16α)(1 −
e^{−√(2/3)φ/M})²` is manifestly a square, hence
* `starobinskyV_nonneg` — non-negative, the strongest form of the correct (elliptic) sign;
* `starobinskyV_zero` — vanishing at `φ = 0`, the flat Minkowski vacuum;
* `starobinskyV_tendsto_plateau` — the large-field plateau `M⁴/(16α)`;
* `starobinskyV_tendsto_atBot_atTop` — the exponential wall as `φ → −∞`.

**3. The conformal-mode potential and its regularization.**
* `confV_completed_square` — `V₃(R_c) = α(R_c − M²/(4α))² − M⁴/(16α)`;
* `confV_ge`, `confV_bddBelow` — bounded below by `−M⁴/(16α)` for `α > 0`;
* `confV_zero_alpha_tendsto_atBot` — and *not* bounded below when `α = 0`: this is exactly
  what the `αR²` term buys.

**4. The mode Hamiltonian, its essential self-adjointness and its flow.**  In the
densitized variables the gravity fiber operator is multiplication by the mode symbol
`(1/16)a_k² − (1/24)b_k² + V_k` (`BookProof.ChapterQuantumGravityDensitized`); with the
Starobinsky conformal-mode potential `V_k = V₃(R_c k)` this is `qgR2ModeHamiltonian`, and
* `qgR2Mode_potential_ge` — its potential part is bounded below by `−M⁴/(16α)`, uniformly
  in the mode, which is the regularization at the level of the operator;
* `qgR2Mode_esa` — it is essentially self-adjoint on its maximal domain (deficiency trivial
  at every non-real `z`, `qgR2Mode_deficiencyTrivialAt`);
* `mulSymbolDomain_dense` — that domain is dense (it contains the finitely supported
  states);
* **`qgR2_stone_flow`** — hence, through the Stone bridge, it generates the complete unitary
  group `e^{−itH}` solving the Schrödinger equation on its domain: the first continuous flow
  for the gauge-fixed `R + αR²` gravity Hamiltonian in this development, the QG analogue of
  `ns_stone_flow` / `ym_fock_stone_flow`.

## Honest boundary

Unchanged from `CONSOLIDATED_PLAN.md` §10.3/§10.5.  The flow above is that of the
*mode* (Hermite-basis) realization, where the fiber operator is a multiplication operator;
the continuum `L²(ℝ⁸⁴)` statement with the full polynomial potential still needs the
Strichartz finite-speed / direct-integral input, and the gauge/BRST sector is outside the
statement.  No mass gap and no global existence is claimed.  The potentials formalized here
are the mathematics of the derivation, not the symbolic-algebra program that produced it.
-/

open Filter Topology

namespace BookProof.Starobinsky

open BookProof.FarisLavine BookProof.NavierStokesFlow
open BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

/-! ## 1. The `f(R)` function and its scalar–tensor form -/



/-- The scalar-tensor field `ψ = 1 + 4αR/M²`. -/
def scalaron (M alpha R : ℝ) : ℝ := 1 + 4 * alpha * R / M ^ 2





/-! ## 2. The Einstein-frame scalaron potential -/

/-- The Einstein-frame scalaron potential
`V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²`. -/
def starobinskyV (M alpha phi : ℝ) : ℝ :=
  M ^ 4 / (16 * alpha) * (1 - Real.exp (-(Real.sqrt (2 / 3)) * phi / M)) ^ 2

/-- **The scalaron potential is non-negative** — it is a square times a positive constant.
This is the strongest form of the sign condition the elliptic essential-self-adjointness
arguments need. -/
theorem starobinskyV_nonneg {M alpha : ℝ} (halpha : 0 < alpha) (phi : ℝ) :
    0 ≤ starobinskyV M alpha phi := by
  have h16 : (0 : ℝ) < 16 * alpha := by linarith
  have h1 : 0 ≤ M ^ 4 / (16 * alpha) := div_nonneg (by positivity) h16.le
  exact mul_nonneg h1 (sq_nonneg _)







/-! ## 3. The conformal-mode potential, and what `αR²` buys -/











/-! ## 4. The mode Hamiltonian, its essential self-adjointness and its unitary flow -/





variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc : ℕ → ℝ)















end

end BookProof.Starobinsky



/-!
# Chapter FockCubicUnbounded — the quadratic degree is the boundary

`ChapterFockFieldPerturbation` proves that a gap survives a *linear* field coupling
`Φ(f) = a†(f) + a(f)`, and `ChapterFockPairPerturbation` that it survives a *quadratic*,
pair-creating coupling `P(f,g) = a†(f)a†(g) + a(g)a(f)`.  Both proceed by dominating the
perturbing form by the free form `Re⟪u, dΓ(h)u⟫`.  Every status update of
`CONSOLIDATED_PLAN.md` then records the same honest boundary: the *cubic and quartic*
Yang–Mills interaction terms are not covered.

This chapter shows that this is not a gap in the write-up but a fact about the route: the
domination that the linear and quadratic couplings admit **fails outright** at degree three.

## Deliverables

* `cubeA k` — the single-mode cubic field term `C_k = (a_k†)³ + (a_k)³`, self-adjoint,
  unbounded, and changing the particle number by three;
* `trial_numberQuad`, `trial_norm_sq`, `trial_cubic_form` — the exact values of the three
  relevant quantities on the two-term trial states `|n⟩ + c|n+3⟩`: the number form
  `n + (n+3)c²`, the squared norm `1 + c²`, and the cubic form `2c√((n+1)(n+2)(n+3))`;
* **`cubic_no_relative_form_bound`** — for *every* pair of constants `a, b` there is a
  vacuum-orthogonal finite-particle state with
  `a·⟪u, N u⟫ + b‖u‖² < Re⟪u, C_k u⟫`.  So the cubic term admits **no** relative form bound
  of the shape `|v| ≤ a q + b‖·‖²` against the number form — the hypothesis of
  `FockInteractionStability.gap_persists_of_relative_form_bound` can never be met by it,
  however small the coupling constant is made;
* **`fock_gap_fails_for_cubic`** — the consequence for the gap: for the free Fock
  Hamiltonian `dΓ(N)` (one-particle gap `1`) and *any* coupling strength `lam > 0`, the
  perturbed form `dΓ(N) + lam·C_k` is **unbounded below** on the vacuum-orthogonal sector:
  for every `M` there is a vacuum-orthogonal state with
  `Re⟪u, dΓ(N)u⟫ + lam·Re⟪u, C_k u⟫ ≤ -M‖u‖²`.

Together with `ChapterFockPairPerturbation`, this locates the boundary exactly: degree two
survives (with a smallness condition), degree three does not survive at all.

A final section makes the complementary point precise.  `quartA k = (a_k†)²(a_k)²` is the
normal-ordered quartic term, diagonal with eigenvalue `m(m − 1)` (`quartA_single_confAt`,
`trial_quartic_form`), and **`trial_cubic_quartic_bounded_below`** shows that on the very
family of states that drives `dΓ(N) + lam·C_k` to `-∞`, the sum
`dΓ(N) + lam·C_k + Q_k` is bounded below by `-(lam⁴/4 + 2lam²)‖u‖²`, uniformly in the
occupation number and in the mixing coefficient.  The divergence above is therefore a
property of a *bare* cubic term.

## Honest boundary

`C_k` is a single-mode cubic term, not the full Yang–Mills cubic vertex; what is proved is
that *this* form-domination route cannot reach degree three, not that no gap exists for the
physical theory — a physical cubic term is accompanied by a quartic term which is bounded
below, and controlling their sum in general is a different problem, of which only the
statement along the above trial family is proved here.  `1.932` remains a certified
truncated number; no mass gap of the physical Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockCubicUnbounded

open BookProof.FockSecondQuantization

/-! ## 1. Single-mode configurations -/

/-- The occupation-`m` configuration of the mode `k`. -/
def confAt (k m : ℕ) : Conf := Finsupp.single k m













/-! ## 2. The cubic field term -/







/-! ## 3. The two-term trial states -/

/-- The trial state `|n⟩ + c|n+3⟩` of the mode `k`. -/
def trial (k n : ℕ) (c : ℝ) : FockAlg :=
  Finsupp.single (confAt k n) 1 + Finsupp.single (confAt k (n + 3)) ((c : ℝ) : ℂ)











/-! ## 4. The three quantities on a trial state -/







/-! ## 5. No relative form bound at degree three -/





/-! ## 6. The quartic term restores a lower bound on the same witnesses -/









/-! ## 7. Axiom audit -/

section Audit

#print axioms trial_numberQuad
#print axioms trial_cubic_form
#print axioms cubic_no_relative_form_bound
#print axioms fock_gap_fails_for_cubic
#print axioms quartA_single_confAt
#print axioms trial_quartic_form
#print axioms trial_cubic_quartic_bounded_below

end Audit

end BookProof.FockCubicUnbounded

end



/-!
# The Gauss–polynomial (Hermite) core: the one-particle Hamiltonian is well defined on it

Plan item **§10.6.1, target 1** of `CONSOLIDATED_PLAN.md`: *well-definedness of the
gauge-fixed `R + αR²` one-particle Hamiltonian on the Gauss–polynomial core*.

The scalaron potential `V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²` grows **exponentially** as
`φ → −∞`, so it is not of temperate growth and the Schwartz-core multiplication theorem does
not apply to it.  The Gauss–polynomial core `p(x)e^{−x²/4}` — the basis in which the SIRK
numerics actually work — is nevertheless a legitimate domain for it, because its Gaussian
tail **dominates every exponential**.

## What is proved

**1. Gaussian dominance of exponentials.**  `exp_abs_le_const_mul_exp_sq`: for every `c ≥ 0`
and every `x`, `e^{c|x|} ≤ e^{2c²} e^{x²/8}`; hence `exp_abs_mul_gaussH_le`
`e^{c|x|}e^{−x²/4} ≤ e^{2c²}e^{−x²/8}`, and `tendsto_exp_abs_mul_gaussH_cocompact` — the
product tends to `0` at infinity.

**2. The exponential growth class.**  `ExpBounded f` says `|f x| ≤ C e^{c|x|}` for some
constants.  It contains every polynomial (`expBounded_poly`), is closed under sums and
scalar multiples, and contains the scalaron potential (`expBounded_starobinskyV`) — for
which no temperate bound exists.

**3. Multiplication by such a potential maps the core into `L²`.**
`memLp_gaussPoly` (the core lies in `L²`), `memLp_mul_gaussPoly_of_expBounded` (an
exp-bounded continuous potential times a core element is in `L²`), and the instances
`memLp_starobinskyV_mul_gaussPoly` and `memLp_scalaronFull1D_mul_gaussPoly` for the scalaron
potential and for the full one-variable potential `V₃ + V` (conformal-mode parabola plus
scalaron).

**4. The core is invariant under the kinetic term.**  `hasDerivAt_gaussPoly` shows the
derivative of a Gauss polynomial is the Gauss polynomial of `p' − x p / 2`
(`gaussPolyDeriv`), so `deriv_gaussPoly` and `deriv2_gaussPoly` stay in the core, and
`memLp_hamiltonian_gaussPoly` concludes: **`H ψ = −ψ'' + Wψ` lands in `L²` for every core
element `ψ`**, for every continuous exp-bounded potential `W`, in particular for the
scalaron one (`memLp_scalaronHamiltonian_gaussPoly`).

**6. Symmetry on the core.**  `gint_gaussPolyDeriv_antisymm` and
`gint_gaussPolyDeriv_two_symm` are the integration-by-parts identities at polynomial level
(the boundary terms vanish because of the Gaussian weight), and `integral_kinetic_symm` /
`integral_hamiltonian_symm` conclude that `−d²/dx² + W` is **symmetric** on the core for
every continuous exp-bounded `W` (`integral_scalaronHamiltonian_symm` for the scalaron).
This is the symmetric-operator half of the essential-self-adjointness question; the
deficiency half is not proved here (for the potential term alone it is proved, for
exponentially growing potentials too, in `BookProof.ChapterScalaronHermiteEsa`).

**7. Arbitrary dimension.**  `ExpBounded` is stated for any normed space, and
`memLp_mul_pgFun_of_expBounded` transports item 3 to the project's product Gauss–polynomial
core `pgFun` of `L²(ℝᵈ)` (`BookProof.HermiteProductCore`): multiplication by a continuous,
exponentially bounded potential maps that core into `L²(ℝᵈ)`.  `ExpBounded.comp_coord` and
`exists_exp_bound_mvPolyEval` are the two ingredients, and
`memLp_scalaronSectorPotential_mul_pgFun` is the instance for the **reduced two-variable
sector** `(R_c, φ)` with the potential `V₃(R_c) + V(φ)`.

This answers, in the Hermite basis, the domain question that §10.3 flags for the raw
operator.  It does **not** by itself give essential self-adjointness (targets 2–4 of
§10.6.1); those remain open.
-/

namespace BookProof.QgHermiteCore

open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

/-! ## 1. The Gaussian tail dominates every exponential -/







/-! ## 2. The exponential growth class -/

section ExpBoundedGeneral

variable {E : Type*} [NormedAddCommGroup E]











end ExpBoundedGeneral









/-! ## 3. The Gauss–polynomial core, and multiplication by such a potential -/

/-- A **Gauss polynomial** `p(x)e^{−x²/4}`: the generic element of the Hermite core. -/
noncomputable def gaussPoly (p : Polynomial ℝ) (x : ℝ) : ℝ := p.eval x * gaussH x













/-! ## 4. The core is invariant under differentiation -/













/-! ## 6. Symmetry of the Hamiltonian on the core -/

















/-! ## 7. Arbitrary dimension: the product Gauss–polynomial core of `L²(ℝᵈ)` -/

section MultiDim

open BookProof.HermiteProductCore

variable {d : ℕ}







/-! ### The reduced `(R_c, φ)` sector -/









end MultiDim

end BookProof.QgHermiteCore



/-!
# The quadrature operator `∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)` on the Hermite core

`BookProof.ChapterHermiteRelativeBound` proves that the first-order operator
`B = ∑ᵢ (bᵢ xᵢ + b'ᵢ πᵢ)` (`foOp b b'`) is symmetric on the Gauss–polynomial
(product Hermite) core of `L²(ℝᵈ)`, and that `H_c + B` is essentially self-adjoint
whenever the quadratic part `H_c` is *elliptic*.  The shifted-core modules
(`ChapterShiftedQuadraticEsa`, `ChapterShiftedQuadraticMatrixEsa`,
`ChapterShiftedQuadraticDegenerate`) remove the sign and the invertibility
conditions by completing the square, but need a classical equilibrium — which does
not exist in a kernel direction carrying both a linear potential `bᵢxᵢ` and a
momentum term `b'ᵢπᵢ`.  There the operator has no quadratic part at all, and the
two routes used elsewhere both fail: it has no `L²` eigenvector (so the
Hermite-eigenbasis argument does not see it) and it is not constant-coefficient
(so the Fourier-multiplier argument does not see it either).
`BookProof.ChapterMixedLinearEsa` settles that operator on the **Schwartz** core, by
a quadratic gauge.  This module settles it on the **Gauss–polynomial core** — the
core the whole quadratic family lives on — by the metaplectic rotation, which on
that core is nothing but a phase.

## What is proved

* `fourier_eq_zero_of_moments`, `ae_eq_zero_of_moments'` — **a moment lemma without
  an `L²` hypothesis**: a function all of whose exponentially weighted moments are
  finite and all of whose polynomial moments vanish is zero almost everywhere.
  This strengthens `BookProof.HermiteProductCore.ae_eq_zero_of_moments`, which
  needs the function to be a Gaussian times an `L²` function, and is what lets the
  deficiency equation of a *multiplication* operator be treated on the
  Gauss–polynomial core (there the natural function is `e^{-‖x‖²/4}(ℓ − z)u`, which
  is not of that shape);
* `foOp_pos_deficiencyTrivialAt`, `foOp_pos_essentiallySelfAdjoint` — multiplication
  by the real linear function `x ↦ ⟪x, b⟫` is essentially self-adjoint on the core;
* `phaseBasis`, `phaseU`, `phaseU_hermiteMvLp` — **the instrument**: a unimodular
  multiplier on a Hilbert basis is a unitary of the space, sending each basis vector
  to its phase multiple;
* `posL_hermiteCore`, `momL_hermiteCore`, `foOp_hermiteCore` — the ladder form of the
  canonical pair on the product Hermite basis: the quadrature raises the `i`-th
  excitation number with amplitude `wᵢ = bᵢ + ib'ᵢ/2` and lowers it with `conj wᵢ`;
* `phaseU_foOp_hermiteCore` — the phase unitary rotates the canonical pair: it carries
  `foOp r 0` onto `foOp b b'` when `ζᵢ = wᵢ/|wᵢ|`, `rᵢ = |wᵢ|`.  This is the metaplectic
  rotation `e^{iθ·N}`, realized diagonally on the Hermite basis;
* HEADLINE `foOp_essentiallySelfAdjoint` — for **arbitrary** real coefficients
  `b, b'` the quadrature `∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)` is essentially self-adjoint on the
  Gauss–polynomial core of `L²(ℝᵈ)`, and `foOp_stone_flow` turns that into a
  complete unitary flow.

A reusable by-product is `linearMap_ext_of_span`: two linear maps out of a submodule
spanned by a family agree as soon as they agree on that family.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.QuadratureEsa

open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

/-! ## 1. A moment lemma without an `L²` hypothesis -/







/-! ## 2. Multiplication by a real linear function on the Hermite core -/















/-! ## 3. The metaplectic phase rotation on the product Hermite basis -/





/-! ### The core vector carried by a product Hermite function -/

/-- The normalized product Hermite function `ψ_α`, as an element of the core. -/
noncomputable def hermiteCore (a : Fin d →₀ ℕ) : polyGaussCore (d := d) :=
  coreEquiv (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a)





/-! ### The canonical pair in terms of the ladder operators -/

















/-! ### The complex amplitude of a quadrature -/

/-- The complex amplitude `wᵢ = bᵢ + i b'ᵢ/2` of the quadrature `bᵢxᵢ + b'ᵢπᵢ`: it is the
coefficient with which the quadrature raises the `i`-th excitation number. -/
noncomputable def foAmp (b b' : Fin d → ℝ) (i : Fin d) : ℂ :=
  ((b i : ℝ) : ℂ) + Complex.I * ((b' i : ℝ) : ℂ) / 2

















/-! ### The diagonal phase unitary -/





























/-! ### The rotation of the quadrature -/







end BookProof.QuadratureEsa



/-!
# The scalaron sector: essential self-adjointness with an exponentially growing potential

Plan item **A5** (`CONSOLIDATED_PLAN.md` §10.5), the step that the Starobinsky wave left
open at the *continuum* level: the Einstein-frame scalaron potential

`V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²`

is **not** of temperate growth — it grows exponentially as `φ → −∞`, so the
multiplication-operator theorem of `BookProof.ChapterWaveUnboundedPotential`
(`potentialOp_essentiallySelfAdjoint`, stated for potentials of temperate growth on the
Schwartz core) does not apply to it.  This module removes that restriction.

## The point

Temperate growth is needed only to make the *Schwartz* core invariant.  On the smaller —
and still dense — core of **smooth compactly supported** functions no growth hypothesis is
needed at all: multiplication by any smooth real function maps the core into itself, and the
deficiency argument of `ChapterWaveUnboundedPotential` (divide a test bump `χ` by the
nowhere-vanishing smooth function `W − z̄`) stays inside the core.  What survives of the
analytic hypotheses is only what the plan records: *the operator must be defined on a dense
core*, and for the combination with the kinetic term the potential must be *bounded below*
— and the Starobinsky potential is bounded below in the strongest way, being a square.

## What is proved

**1. The compactly supported smooth core.**  `ccDomain E` is the image in `L²(E)` of the
smooth compactly supported functions, `ccDomain_dense` its density, and
`ccDomain_le_schwartzDomain` the inclusion in the Schwartz core.

**2. Multiplication by an arbitrary smooth potential.**  `opCc W hW` is multiplication by a
real `W`, assumed *only* smooth: `smoothPotential_symmetric`,
`smoothPotential_deficiencyTrivial` (at every non-real `z`) and
`smoothPotential_essentiallySelfAdjoint`.  No growth, no boundedness and no semiboundedness
hypothesis.

**3. The scalaron potential.**  `contDiff_starobinskyV`; `starobinskyV_not_hasTemperateGrowth`
— the potential genuinely falls outside the temperate class, so item 2 is needed;
`starobinskyV_essentiallySelfAdjoint` — and it is nevertheless essentially self-adjoint on
the compactly supported core, as is the full `V₃(R_c) + V(φ)` potential of the gauge-fixed
`R + αR²` Hamiltonian (`scalaronFullPotential_essentiallySelfAdjoint`), which is moreover
bounded below by `−M⁴/(16α)` (`scalaronFullPotential_ge`).

**4. The d'Alembertian with the scalaron potential.**  `wave_add_scalaron_symmetric` — the
gauge-fixed Hamiltonian `□ + V` is a well-defined symmetric operator on the dense compactly
supported core, and `wave_add_smoothTruncatedPotential_essentiallySelfAdjoint` — every
localization of it is essentially self-adjoint on the Schwartz core, again with smoothness
as the only hypothesis on the potential (`wave_add_scalaronTruncated_esa` for the scalaron
potential itself).  This is the exponential-growth analogue of
`wave_add_truncatedPotential_essentiallySelfAdjoint`.

**5. The full mode Hamiltonian with the scalaron sector, and its flow.**  At the mode level
the gravity fiber operator is multiplication by `(1/16)a_k² − (1/24)b_k² + V₃(R_c k) +
V(φ_k)`: `qgScalaronMode_esa` (essential self-adjointness on the dense maximal domain),
`qgScalaronMode_potential_ge` (the uniform lower bound `−M⁴/(16α)`, unaffected by the
non-negative scalaron term) and **`qgScalaron_stone_flow`** — the complete unitary group of
the `R + αR²` Hamiltonian *including* the scalaron potential.

## Honest boundary

Unchanged from `CONSOLIDATED_PLAN.md` §10.3/§10.5: the continuum `L²(ℝ⁸⁴)` essential
self-adjointness of the *sum* `□ + V` still needs the Strichartz finite-speed / gluing
input, which is not claimed here.  What this module settles is the point at issue for the
scalaron: the exponential wall is not an obstruction — the potential term is essentially
self-adjoint on a dense core with no growth hypothesis, every localization of the sum is
essentially self-adjoint, and the potential has the correct (bounded below) sign.
-/

open Filter Topology MeasureTheory SchwartzMap

namespace BookProof.ScalaronEsa

open BookProof.StrichartzWave BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.NavierStokesFlow
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

/-! ## 1. The compactly supported smooth core -/

/-- The compactly supported Schwartz functions, as a submodule of `𝓢(E, ℂ)`. -/
def ccSchwartz (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E] : Submodule ℂ 𝓢(E, ℂ) where
  carrier := {f | HasCompactSupport (f : E → ℂ)}
  add_mem' := by
    intro f g hf hg
    have h : HasCompactSupport ((f : E → ℂ) + (g : E → ℂ)) := hf.add hg
    refine h.mono ?_
    intro x hx
    simp only [Function.mem_support, SchwartzMap.add_apply] at hx ⊢
    simpa using hx
  zero_mem' := by
    have h : HasCompactSupport (fun _ : E => (0 : ℂ)) := HasCompactSupport.zero
    exact h.mono (by intro x hx; simp at hx)
  smul_mem' := by
    intro c f hf
    refine hf.mono ?_
    intro x hx
    simp only [Function.mem_support, SchwartzMap.smul_apply, smul_eq_mul, ne_eq] at hx ⊢
    intro h
    exact hx (by simp [h])



/-- The compactly supported smooth functions, mapped into `L²(E)`. -/
def ccInclLM (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E] :
    ccSchwartz E →ₗ[ℂ] Lp ℂ 2 (volume : Measure E) :=
  (toLpCLM ℂ ℂ 2 (volume : Measure E)).toLinearMap ∘ₗ (ccSchwartz E).subtype

lemma ccInclLM_apply (f : ccSchwartz E) :
    ccInclLM E f = ((f : 𝓢(E, ℂ)).toLp 2 (volume : Measure E)) := rfl

lemma ccInclLM_injective : Function.Injective (ccInclLM E) := by
  intro f g hfg
  exact Subtype.ext (SchwartzMap.injective_toLp 2 (volume : Measure E) hfg)

/-- **The compactly supported smooth core** of `L²(E)`. -/
def ccDomain (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E] :
    Submodule ℂ (Lp ℂ 2 (volume : Measure E)) := LinearMap.range (ccInclLM E)

/-- Compactly supported smooth functions are in bijection with the core. -/
def ccEquiv (E : Type*) [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    [FiniteDimensional ℝ E] [MeasurableSpace E] [BorelSpace E] :
    ccSchwartz E ≃ₗ[ℂ] ccDomain E :=
  LinearEquiv.ofInjective (ccInclLM E) ccInclLM_injective

@[simp] lemma ccEquiv_coe (f : ccSchwartz E) :
    ((ccEquiv E f : ccDomain E) : Lp ℂ 2 (volume : Measure E))
      = (f : 𝓢(E, ℂ)).toLp 2 (volume : Measure E) := rfl

/-- The compactly supported core sits inside the Schwartz core. -/
lemma ccDomain_le_schwartzDomain : ccDomain E ≤ schwartzDomain E := by
  rintro _ ⟨f, rfl⟩
  exact ⟨(f : 𝓢(E, ℂ)), rfl⟩

/-- **The compactly supported smooth core is dense** in `L²(E)`. -/
theorem ccDomain_dense : Dense ((ccDomain E : Submodule ℂ (Lp ℂ 2 (volume : Measure E))) :
    Set (Lp ℂ 2 (volume : Measure E))) := by
  have hd : Dense {f : Lp ℂ 2 (volume : Measure E) | ∃ g, (f : E → ℂ) =ᵐ[volume] g ∧
      HasCompactSupport g ∧ ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g} :=
    MeasureTheory.Lp.dense_hasCompactSupport_contDiff (by norm_num)
  refine Dense.mono ?_ hd
  rintro f ⟨g, hfg, hgc, hgs⟩
  refine ⟨⟨hgc.toSchwartzMap hgs, hgc⟩, ?_⟩
  rw [ccInclLM_apply]
  refine MeasureTheory.Lp.ext ?_
  filter_upwards [(hgc.toSchwartzMap hgs).coeFn_toLp 2 (volume : Measure E), hfg]
    with x hx hy
  rw [hx, hy]
  rfl

/-! ## 2. Multiplication by an arbitrary smooth real potential -/

/-- Multiplication by a real `W`, as a map of the compactly supported core into Schwartz
space.  Only smoothness of `W` is required: compact support of `f` does the rest. -/
def mulCc (W : E → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) :
    ccSchwartz E →ₗ[ℂ] 𝓢(E, ℂ) where
  toFun f :=
    (HasCompactSupport.mul_left f.2 :
        HasCompactSupport (fun x => (W x : ℂ) * (f : 𝓢(E, ℂ)) x)).toSchwartzMap
      ((Complex.ofRealCLM.contDiff.comp hW).mul ((f : 𝓢(E, ℂ)).smooth _))
  map_add' f g := by
    refine SchwartzMap.ext fun x => ?_
    change (W x : ℂ) * ((f : 𝓢(E, ℂ)) x + (g : 𝓢(E, ℂ)) x)
      = (W x : ℂ) * (f : 𝓢(E, ℂ)) x + (W x : ℂ) * (g : 𝓢(E, ℂ)) x
    ring
  map_smul' c f := by
    refine SchwartzMap.ext fun x => ?_
    change (W x : ℂ) * (c • (f : 𝓢(E, ℂ))) x = c • ((W x : ℂ) * (f : 𝓢(E, ℂ)) x)
    simp only [SchwartzMap.smul_apply, smul_eq_mul]
    ring

@[simp] lemma mulCc_apply (W : E → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (f : ccSchwartz E) (x : E) :
    (mulCc W hW f) x = (W x : ℂ) * (f : 𝓢(E, ℂ)) x := rfl

/-- Multiplication by a smooth real potential, as an unbounded operator on `L²(E)` with the
compactly supported smooth core as its domain. -/
def opCc (W : E → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) :
    ccDomain E →ₗ[ℂ] Lp ℂ 2 (volume : Measure E) :=
  (toLpCLM ℂ ℂ 2 (volume : Measure E)).toLinearMap ∘ₗ mulCc W hW ∘ₗ
    (ccEquiv E).symm.toLinearMap

@[simp] lemma opCc_apply (W : E → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (f : ccSchwartz E) :
    opCc W hW (ccEquiv E f) = (mulCc W hW f).toLp 2 (volume : Measure E) := by
  simp [opCc]

/-- A real potential, smooth but otherwise arbitrary, is symmetric on the compactly
supported core. -/
theorem smoothPotential_symmetric (W : E → ℝ)
    (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) :
    SymmetricOn (ccDomain E) (opCc W hW) := by
  intro x y
  obtain ⟨f, rfl⟩ := (ccEquiv E).surjective x
  obtain ⟨g, rfl⟩ := (ccEquiv E).surjective y
  rw [opCc_apply, opCc_apply, ccEquiv_coe, ccEquiv_coe, inner_toLp_left, inner_toLp_left]
  refine integral_congr_ae ?_
  filter_upwards [(g : 𝓢(E, ℂ)).coeFn_toLp 2 (volume : Measure E),
    (mulCc W hW g).coeFn_toLp 2 (volume : Measure E)] with x hx hy
  rw [hx, hy]
  simp only [mulCc_apply, map_mul, Complex.conj_ofReal]
  ring







/-! ## 3. The Starobinsky scalaron potential -/

/-- The scalaron potential is smooth. -/
theorem contDiff_starobinskyV (M alpha : ℝ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (fun phi : ℝ => starobinskyV M alpha phi) := by
  unfold starobinskyV
  exact contDiff_const.mul
    ((contDiff_const.sub (Real.contDiff_exp.comp
      ((contDiff_const.mul contDiff_id).div_const M))).pow 2)















/-! ## 4. The d'Alembertian with the scalaron potential -/





/-- A symmetric operator stays symmetric on a smaller domain. -/
theorem symmetricOn_inclusion {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    {D D' : Submodule ℂ F} (h : D ≤ D') (T : D' →ₗ[ℂ] F) (hT : SymmetricOn D' T) :
    SymmetricOn D (T ∘ₗ Submodule.inclusion h) := by
  intro x y
  simpa using hT (Submodule.inclusion h x) (Submodule.inclusion h y)















/-! ## 5. The mode Hamiltonian with the scalaron sector, and its flow -/

variable (a b : ℕ → ℝ) (M alpha : ℝ) (Rc phi : ℕ → ℝ)















end

end BookProof.ScalaronEsa



/-!
# The exponential wall is not a relatively bounded perturbation (plan §10.6.1, target 2)

`CONSOLIDATED_PLAN.md` §10.6.1 target 2 proposes to obtain essential self-adjointness of
the one-particle scalaron Hamiltonian on the Gauss–polynomial (Hermite) core by a
Kato–Rellich argument: *"`V(φ)` is `(−Δ)`-bounded with arbitrarily small relative bound on
the Gauss core"*.  The plan itself flags that this target "needs restating".  This module
proves that it is in fact **false**, in the strongest sense: the scalaron potential is not
relatively bounded on the Hermite core with respect to the kinetic term, nor with respect
to the harmonic (conformal-mode) oscillator `−Δ + x²/4` — not with a small relative bound,
and not with *any* pair of constants.

## The mechanism

On the monomial core elements `ψ_N(x) = x^N e^{−x²/4}` the reference operators grow only
polynomially in `N`, because they act on the core by polynomial maps of fixed degree
increment:

* `osc_psi` — `(−d²/dx² + x²/4)(x^N e^{−x²/4}) = ((N + ½)x^N − N(N−1)x^{N−2})e^{−x²/4}`,
  so `‖H₀ψ_N‖ ≤ (N² + 1)‖ψ_N‖` (`l2_osc_le`);
* `neg_deriv2_psi` — `−d²/dx²(x^N e^{−x²/4}) = ((N + ½)x^N − N(N−1)x^{N−2} − ¼x^{N+2})e^{−x²/4}`,
  so `‖−ψ_N''‖ ≤ (N² + 1)‖ψ_N‖` (`l2_kin_le`).

The exponential wall, on the other hand, grows *super-polynomially* along the same family.
The quadratic form of the potential is an exponentially tilted Gaussian moment, and
expanding the tilt to eighth order gives

* `gaussMoment_tilt_ge` — `∫ e^{−2sx}x^{2N}e^{−x²/2}dx ≥ (2s⁸/315)·M_{2N+8}`,
* `gaussMoment_shift_eight` — `M_{2N+8} = (2N+7)(2N+5)(2N+3)(2N+1)·M_{2N}`,

hence `⟪ψ_N, Vψ_N⟫ ≥ c₀(K N⁴ − 1)‖ψ_N‖²` with `K = 8s⁸/315` (`quadForm_scalaron_ge`), and
Cauchy–Schwarz turns this into `‖Vψ_N‖ ≥ c₀(K N⁴ − 1)‖ψ_N‖` (`l2_scalaron_ge`).  A quartic
lower bound against a cubic upper bound is the contradiction.

## What is proved

* `not_relatively_bounded_of_cubic` — the abstract form: no operator whose norm along the
  monomial family grows at most cubically can dominate the scalaron potential;
* **`scalaronV_not_kinetic_relativelyBounded`** — there are **no** constants `a, b` with
  `‖Vψ‖ ≤ a‖ψ''‖ + b‖ψ‖` for all Gauss polynomials `ψ`;
* **`scalaronV_not_oscillator_relativelyBounded`** — there are **no** constants `a, b` with
  `‖Vψ‖ ≤ a‖(−Δ + x²/4)ψ‖ + b‖ψ‖` for all Gauss polynomials `ψ`.

Consequently the Kato–Rellich route of §10.6.1 target 2 — and, a fortiori, the
"arbitrarily small relative bound" it asks for — cannot be taken for the exponential wall,
either against the free kinetic term or against the conformal-mode oscillator whose Hermite
functions define the core.  This is a genuine obstruction, not a gap in the argument: it is
why `BookProof.ChapterQgHermiteOscillatorEsa` can only reach *bounded* perturbations of the
oscillator by Kato–Rellich, and why the exponential case in
`BookProof.ChapterScalaronHermiteEsa` had to be handled by a Fourier/moment argument
instead.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.HermiteExpWall

open MeasureTheory Polynomial
open BookProof.HermiteCore BookProof.Starobinsky BookProof.QgHermiteCore
open BookProof.HermiteProductCore

noncomputable section





/-! ## 1. Gaussian moments -/











/-! ## 2. The exponentially tilted moment -/







/-! ## 3. The core family -/

/-- The monomial core elements `ψ_N(x) = x^N e^{−x²/4}`. -/
noncomputable def psi (N : ℕ) : ℝ → ℝ := gaussPoly ((Polynomial.X : Polynomial ℝ) ^ N)

















/-! ## 4. The quadratic form of the wall -/







/-! ## 5. The reference operators grow polynomially

Both `−d²/dx²` and `−d²/dx² + x²/4` map the monomial core family into itself, shifting the
degree by at most two, so their `L²` norms along the family grow only polynomially in `N`. -/

















































/-! ## 6. No relative bound -/







end

end BookProof.HermiteExpWall



/-!
# The general mode-diagonal quadratic Hamiltonian on the Gauss–polynomial core

`BookProof.ChapterHermiteCarlemanEsa` proves essential self-adjointness, on the plain
Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`, of

`∑ᵢ cᵢ(πᵢ² + xᵢ²/4) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

for **arbitrary** real `c, b, b'`.  The quadratic part there is the *harmonic* one: in
each mode it is a multiple of the harmonic oscillator `πᵢ² + xᵢ²/4`, which is diagonal on
the Hermite basis.  The one-mode real quadratic forms make up a three-dimensional space,
spanned by `πᵢ²`, `xᵢ²` and the squeezing (dilation) generator `½(xᵢπᵢ + πᵢxᵢ)`, and
only a one-dimensional subspace of it is diagonal.

This module removes that last restriction: for **arbitrary** real `p, q, s, b, b'` the
operator

`H = ∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is essentially self-adjoint on the plain Gauss–polynomial core.  Every real quadratic
Hamiltonian which does not couple distinct modes is of this form — elliptic, hyperbolic
or parabolic in each mode, with any signs, with degenerate modes allowed, and with an
arbitrary constant force and boost on top.  In particular (taking `p = q = b = b' = 0`,
`s = 1`) the generator of dilations `½∑ᵢ(xᵢπᵢ + πᵢxᵢ)` is essentially self-adjoint on the
core.

## What is proved

* `lop`, `lop_hermiteMv`, `lop_lop_hermiteMv` — the two-step ladder algebra.  Both `xᵢ`
  and `πᵢ` are of the form `aᵢ† + t aᵢ` up to a scalar, so a product of two of them moves
  the `i`-th excitation number by `0` or `±2`; the `±2` amplitudes are `√((αᵢ+1)(αᵢ+2))`
  and `√(αᵢ(αᵢ−1))`, of size `O(αᵢ)`.
* `mqQuadPoly`, `mqPoly`, `mqOp` — the Hamiltonian, assembled from Weyl-ordered products
  of the canonical pair, hence symmetric on the core (`mqOp_symmetric`).
* `mqQuadPoly_hermiteMv`, `mqOp_hermiteCore` — the ladder form of the Hamiltonian: a real
  diagonal `∑ᵢ(qᵢ + pᵢ/4)(2αᵢ+1)`, a two-step amplitude `qᵢ − pᵢ/4 + i sᵢ/2`, and the
  one-step amplitude `bᵢ + i b'ᵢ/2` of the first-order part.
* `mqOp_deficiencyTrivialAt`, `mqOp_essentiallySelfAdjoint` — **the headline**, by the
  two-step Carleman criterion `BookProof.CarlemanTwoStep.ladder2_eq_zero`.
* `mqOp_stone_flow` — the resulting complete unitary flow, by Stone's theorem.
* `dilation_essentiallySelfAdjoint`, `dilation_stone_flow` — the corollary for the
  generator of dilations.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ModeQuadratic

open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

/-! ## 1. Two-step multi-index arithmetic -/









/-! ## 2. The two-step ladder algebra -/

/-- The generic one-step operator `aᵢ† + t aᵢ`.  Both `xᵢ = aᵢ† + aᵢ` and
`πᵢ = (i/2)(aᵢ† − aᵢ)` are of this shape. -/
def lop (t : ℂ) (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  crePoly i + t • annPoly i









/-! ## 3. The Hamiltonian -/











/-! ### Symmetry -/







/-! ### The ladder form -/











/-! ### Transport to the core -/









/-! ## 4. Essential self-adjointness -/











end

end BookProof.ModeQuadratic



/-!
# The quantum-gravity one-particle Hamiltonian on the Hermite core: symmetry,
semiboundedness, and the Friedrichs extension

`CONSOLIDATED_PLAN.md` §10.6.1 asks for the one-particle gauge-fixed `R + αR²`
Hamiltonian `H = −Δ + W` to be realized as a genuine operator on the
Gauss–polynomial (Hermite) core of `L²(ℝᵈ)` — the basis the SIRK numerics work
in — and for a self-adjoint realization of it.  Target 1 (well-definedness:
`H` maps the core into `L²`) is `BookProof.ChapterQgHermiteCore`.  This module
takes the next step:

* the kinetic term is realized **algebraically** on the core.  Differentiating
  `pgFun p = p(x) e^{−‖x‖²/4}` in the coordinate `j` multiplies the polynomial by
  the *twisted derivative* `coreD j p = ∂ⱼ p − ½ xⱼ p` (`hasDerivAt_pgFun_coord`),
  so the Laplacian acts on the core as the polynomial map
  `kinPoly p = −∑ⱼ coreD j (coreD j p)` (`pgFun_kinPoly`);
* `coreD j` is **antisymmetric** for the Gaussian pairing (`gaussInt_coreD`),
  which is the polynomial form of integration by parts — the analytic input is
  the project's `gaussInt_pderiv`;
* consequently `H = −Δ + W` on the core (`hamCore`) is **symmetric**
  (`hamCore_symmetricOn`) and **bounded below by the lower bound of the
  potential** (`hamCore_quadForm_ge`, `hamCore_quadForm_nonneg`): the kinetic
  quadratic form is the sum of the squared norms of the first derivatives;
* since the core is dense (`polyGaussCore_dense`), the Friedrichs machinery of
  `BookProof.ChapterFriedrichsExtension` yields a **semibounded self-adjoint
  extension** with the same lower bound (`hermiteCore_friedrichs_extension`),
  and a *positive* one when the potential is nonnegative
  (`hermiteCore_friedrichs_extension_of_nonneg`).

The named instances are the ones §10.6.1 asks for: the one-variable **scalaron**
Hamiltonian `−Δ + V(φ)` (`qgOneParticleHermite_friedrichs`) — unconditional, no
finite-speed hypothesis, and with the exponentially growing potential the
temperate-growth theorems cannot reach — and the reduced two-variable sector
`(R_c, φ)` with the conformal-mode parabola
(`qgOneParticleSector_friedrichs`).

**Honest boundary.**  This is the *existence and canonical choice* of a
self-adjoint realization, not the *uniqueness* of one: essential
self-adjointness on the core (§10.6.1 target 4) is not proved here, and no
statement of this module asserts it.  It is proved elsewhere for the two cases
now available — the harmonic potential (`BookProof.ChapterQgHermiteOscillatorEsa`)
and the potential term alone, exponential growth included
(`BookProof.ChapterScalaronHermiteEsa`).
-/

namespace BookProof.QgHermiteFriedrichs

open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.Starobinsky
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension

noncomputable section

variable {d : ℕ}

/-! ## The conjugate polynomial -/

/-- The polynomial with conjugated coefficients; on *real* points it computes the
complex conjugate of the value (`conj_pgFun`). -/
def cpoly (p : MvPolynomial (Fin d) ℂ) : MvPolynomial (Fin d) ℂ :=
  p.map (starRingEnd ℂ)

@[simp] theorem cpoly_add (p q : MvPolynomial (Fin d) ℂ) :
    cpoly (p + q) = cpoly p + cpoly q := by
  simp [cpoly]









theorem conj_polyEval (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    (starRingEnd ℂ) (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p)
      = MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (cpoly p) := by
  induction p using MvPolynomial.induction_on with
  | C a => simp [cpoly]
  | add p q hp hq => simp [hp, hq]
  | mul_X p i hp => simp only [cpoly] at hp ⊢; simp [hp]

theorem conj_pgFun (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    (starRingEnd ℂ) (pgFun p x) = pgFun (cpoly p) x := by
  simp only [pgFun, map_mul, Complex.conj_ofReal, conj_polyEval]

/-! ## The twisted derivative: the Laplacian on the core, algebraically -/





















/-! ## The Gaussian pairing -/

/-- The inner product of two core vectors is the Gaussian integral of the product
of the conjugate polynomial with the other. -/
theorem inner_pgLp_pgLp (p q : MvPolynomial (Fin d) ℂ) :
    (inner ℂ (pgLp p) (pgLp q) : ℂ) = gaussInt (cpoly p * q) := by
  rw [inner_pgLp, gaussInt]
  refine integral_congr_ae ?_
  filter_upwards [pgLp_coeFn q] with x hx
  rw [hx, conj_pgFun]
  simp only [pgFun, map_mul, gaussWD_eq_sq]
  push_cast
  ring















/-! ## The potential term -/

variable (W : Vd d → ℝ)









/-! ## The Hamiltonian on the core -/





/-- The core, as the isomorphic image of the polynomial ring. -/
def coreEquiv : MvPolynomial (Fin d) ℂ ≃ₗ[ℂ] (polyGaussCore (d := d)) :=
  LinearEquiv.ofInjective (pgMap (d := d)) pgMap_injective









/-! ## Symmetry -/













/-! ## Semiboundedness -/











/-! ## The Friedrichs extension -/





/-! ## The scalaron instances -/













/-! ## The kinetic term really is the Laplacian -/















end

end BookProof.QgHermiteFriedrichs



/-!
# The exponential scalaron wall: `−d²/dφ² + V` is essentially self-adjoint

`CONSOLIDATED_PLAN.md` §10.6.1/§10.6.2 leaves one item of the quantum-gravity chapter open:
the Schrödinger operator with the **exponentially growing** Einstein-frame scalaron wall

`V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²`,

whose growth as `φ → −∞` beats every polynomial (`starobinskyV_not_hasTemperateGrowth`).
Every route the project had tried was perturbative relative to the harmonic (Gauss/Hermite)
core, and each of them is *refuted* for such a wall: relative boundedness fails
(`BookProof/ChapterHermiteExpWall.lean`) and the Carleman flux criterion is inapplicable
because `∑ 1/Aₙ` converges.  `BookProof/ChapterScalaronCoreEsa.lean` settles the
multiplication operator alone; what was missing is the **sum** `−d²/dφ² + V`.

## The non-perturbative argument

For a *non-negative* potential the classical argument needs no perturbation theory at all.
A deficiency vector `u ∈ L²(ℝ)` at `z = ±i` satisfies the differential equation
`u'' = (V − z)u` in the sense of distributions.  The regularity toolkit of
`BookProof/ChapterWeakSecondDerivative.lean` upgrades it to a genuine `C²` solution `W`
with `u = W` almost everywhere, and then

`(|W|²)'' = 2 Re(conj W · W'') + 2|W'|² = 2 (V − Re z)|W|² + 2|W'|² ≥ 0`

because `Re z = 0` and `V ≥ 0`.  So `|W|²` is a **convex**, non-negative and *integrable*
function on the whole line — and such a function vanishes identically
(`eq_zero_of_convexOn_nonneg_integrable`: convexity forces
`F(a−s) + F(a+s) ≥ 2F(a)`, so `2 F(a) R ≤ ∫ F` for every `R`).  Hence `u = 0`, both
deficiency spaces are trivial and the operator is essentially self-adjoint.

## What is proved

* `eq_zero_of_convexOn_nonneg_integrable` — a non-negative integrable convex function on
  `ℝ` is zero;
* `ode_solution_eq_zero` — the ODE step: an `L²` solution of `W'' = (V − z)W` with `V ≥ 0`
  and `Re z = 0` vanishes;
* `wallHam` — the operator `−d²/dφ² + V` on the compactly supported smooth core of `L²(ℝ)`,
  with `wallHam_symmetricOn`;
* `wallHam_weak_eq` — the deficiency equation in distributional form;
* **`wallHam_essentiallySelfAdjoint`** — essential self-adjointness for *every* smooth
  `V ≥ 0`, with no growth hypothesis whatsoever;
* `starobinskyWall_esa` — the scalaron instance, and `starobinskyWall_stone_flow` its
  unitary group `e^{−itH}`.
-/

namespace BookProof.ScalaronWallEsa

open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.Starobinsky BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent
open BookProof.WeakSecondDeriv

noncomputable section

/-! ## 1. A non-negative integrable convex function on the line vanishes -/



/-! ## 2. The ODE step -/



/-! ## 3. The Schrödinger operator on the compactly supported smooth core of `L²(ℝ)` -/

/-- The one-dimensional kinetic operator `−d²/dx²` on Schwartz space. -/
def kinOpR : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  constCoeffOp (fun _ : Fin 1 => (-1 : ℝ)) (fun _ : Fin 1 => (1 : ℝ)) 0

lemma kinOpR_apply (f : 𝓢(ℝ, ℂ)) (x : ℝ) :
    (kinOpR f) x = -deriv (deriv (f : ℝ → ℂ)) x := by
  have h : kinOpR f
      = (∑ _i : Fin 1, ((-1 : ℝ) : ℂ) • secondDeriv (1 : ℝ) f) + ((0 : ℝ) : ℂ) • f := by
    simp [kinOpR, constCoeffOp]
  rw [h]
  simp [secondDeriv]
  rfl

/-- The kinetic term on the compactly supported smooth core of `L²(ℝ)`. -/
def kinCcR : ccDomain ℝ →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ) :=
  opL2 kinOpR ∘ₗ Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ))

/-- **The Schrödinger operator `−d²/dx² + V`** on the compactly supported smooth core of
`L²(ℝ)`, for an arbitrary smooth real potential. -/
def wallHam (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) :
    ccDomain ℝ →ₗ[ℂ] Lp ℂ 2 (volume : Measure ℝ) :=
  kinCcR + opCc V hV

theorem kinCcR_symmetricOn : SymmetricOn (ccDomain ℝ) kinCcR :=
  symmetricOn_inclusion _ _ (constCoeffOp_symmetric _ _ _)

theorem wallHam_symmetricOn (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) :
    SymmetricOn (ccDomain ℝ) (wallHam V hV) := by
  intro x y
  have h1 := kinCcR_symmetricOn x y
  have h2 := smoothPotential_symmetric V hV x y
  simp only [wallHam, LinearMap.add_apply, inner_add_left, inner_add_right]
  linear_combination h1 + h2

/-! ## 4. The deficiency equation in distributional form -/









/-! ## 5. Essential self-adjointness -/





/-! ## 6. The scalaron wall -/





end

end BookProof.ScalaronWallEsa



/-!
# The general real quadratic Hamiltonian on the Gauss–polynomial core

`BookProof.ChapterModeQuadraticEsa` proves essential self-adjointness, on the plain
Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`, of the general **mode-diagonal**
quadratic Hamiltonian

`∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

for arbitrary real `p, q, s, b, b'`.  What that leaves open is the coupling of **distinct**
modes: `xᵢxⱼ`, `πᵢπⱼ` and `xᵢπⱼ` with `i ≠ j`.

This module removes that restriction.  For arbitrary real matrices `P, Q, S` and arbitrary
real vectors `b, b'` the Weyl-ordered operator

`H = ∑_{i,j} (Pᵢⱼ πᵢπⱼ + Qᵢⱼ xᵢxⱼ + Sᵢⱼ·½(xᵢπⱼ + πⱼxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

— i.e. *every* real quadratic-plus-linear Hamiltonian in `d` degrees of freedom, with no
ellipticity, no definiteness, no non-degeneracy and no classical equilibrium — is
essentially self-adjoint on the plain Gauss–polynomial core, and hence generates a
complete unitary flow.

## The mechanism

In the ladder variables `xᵢ = aᵢ† + aᵢ`, `πᵢ = (i/2)(aᵢ† − aᵢ)` a product of two of them
is a sum of four hops of the multi-index `α`:

* `α ↦ α + eᵢ + eⱼ` (pair creation), amplitude `√((αᵢ+1)(αⱼ+1))`;
* `α ↦ α − eᵢ − eⱼ` (pair annihilation), amplitude `√(αᵢαⱼ)`;
* `α ↦ α + eᵢ − eⱼ` (mode exchange), amplitude `√(αⱼ(αᵢ+1))`;

plus, when `i = j`, a constant diagonal.  The first two change the total degree `|α|` by
`±2`, the third preserves it.  `BookProof.ChapterCarlemanSimplex` runs the Carleman flux
argument on the simplex shells `{|α| ≤ N}`, which is exactly adapted to this grading: the
mode-exchange hops carry no flux at all (their contribution over a shell is real, because
their amplitude matrix is Hermitian), and the degree-changing hops leak only through a
two-thick boundary shell.

## What is proved

* `lop_lop_hermiteMv_gen`, `weyl_hermiteMv_gen` — the two-index ladder algebra, uniform in
  `i` and `j` (the diagonal `i = j` differs only by an extra constant).
* `fqQuadPoly`, `fqPoly`, `fqOp` — the Hamiltonian, assembled from Weyl-ordered products
  of the canonical pair, hence symmetric on the core (`fqOp_symmetric`).
* `fqQuadPoly_hermiteMv`, `fqOp_hermiteCore` — its ladder form: a real constant diagonal,
  the pair amplitude `Qᵢⱼ − Pᵢⱼ/4 + i Sᵢⱼ/2`, the Hermitian exchange matrix
  `fqExch`, and the one-step amplitude `bᵢ + i b'ᵢ/2` of the first-order part.
* `fqOp_deficiencyTrivialAt`, `fqOp_essentiallySelfAdjoint` — **the headline**, by the
  simplex Carleman criterion `BookProof.CarlemanSimplex.ladderQ_eq_zero`.
* `fqOp_stone_flow` — the resulting complete unitary flow, by Stone's theorem.
* `crossTerm_essentiallySelfAdjoint`, `crossTerm_stone_flow` — the corollary for the
  purely off-diagonal cross term `½(xᵢπⱼ + πⱼxᵢ) + ½(xⱼπᵢ + πᵢxⱼ)`.
* `rotMat`, `fqQuadPoly_rotMat`, `angularMomentum_essentiallySelfAdjoint`,
  `angularMomentum_stone_flow` — an *antisymmetric* exchange matrix realizes the
  angular-momentum generator `xₖπ_l − x_lπₖ`, the compact counterpart of the dilation
  generator; it too is essentially self-adjoint on the core, with a complete flow.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.FullQuadratic

open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanSimplex
open BookProof.ModeQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

/-! ## 1. Two-index multi-index arithmetic -/





















/-! ## 2. The two-index ladder algebra -/







/-! ## 3. The Hamiltonian -/

/-- The pair-creation amplitude `Qᵢⱼ − Pᵢⱼ/4 + i Sᵢⱼ/2`. -/
def fqAmp (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) : ℂ :=
  ((Q i j - P i j / 4 : ℝ) : ℂ) + Complex.I * ((S i j / 2 : ℝ) : ℂ)

/-- The half of the mode-exchange amplitude coming from the ordered pair `(i, j)`. -/
def fqMl (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) : ℂ :=
  ((Q i j + P i j / 4 : ℝ) : ℂ) - Complex.I * ((S i j / 2 : ℝ) : ℂ)

/-- **The mode-exchange amplitude matrix**, which is Hermitian. -/
def fqExch (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) : ℂ :=
  fqMl P Q S i j + (starRingEnd ℂ) (fqMl P Q S j i)



/-- The constant diagonal `∑ᵢ (Qᵢᵢ + Pᵢᵢ/4)` of the Weyl-ordered Hamiltonian. -/
def fqSymbol (P Q : Fin d → Fin d → ℝ) : ℝ := ∑ i, (Q i i + P i i / 4)

/-- The quadratic part `∑_{i,j} (Pᵢⱼπᵢπⱼ + Qᵢⱼxᵢxⱼ + Sᵢⱼ·½(xᵢπⱼ + πⱼxᵢ))`, on polynomial
coordinates, assembled from Weyl-ordered products of the canonical pair. -/
def fqQuadPoly (P Q S : Fin d → Fin d → ℝ) :
    MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  ∑ i, ∑ j, (((P i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly j)
      + ((Q i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly j)
      + ((S i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly j))

/-- The full symbol: quadratic part plus first-order part. -/
def fqPoly (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  fqQuadPoly P Q S + foPoly b b'

/-- **The general real quadratic Hamiltonian** on the Gauss–polynomial core. -/
def fqOp (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (fqPoly P Q S b b')

/-! ### Symmetry -/







/-! ### The ladder form on polynomials -/











/-! ### Transport to the orthonormal basis -/











/-! ## 4. Essential self-adjointness -/











/-! ## 5. The angular-momentum generators

An **antisymmetric** exchange matrix `S` picks out the rotation generators: since `xᵢ`
and `πⱼ` commute for `i ≠ j` and the diagonal of `S` vanishes,
`∑_{i,j} Sᵢⱼ·½(xᵢπⱼ + πⱼxᵢ) = ∑_{i<j} Sᵢⱼ (xᵢπⱼ − xⱼπᵢ)`.  The elementary antisymmetric
matrix therefore realizes the angular-momentum generator `xₖπ_l − x_lπₖ`, the compact
counterpart of the dilation generator of `BookProof.ModeQuadratic`. -/

/-- The elementary antisymmetric matrix `E_{kl} − E_{lk}`. -/
def rotMat (k l : Fin d) : Fin d → Fin d → ℝ := fun i j =>
  (if i = k then (if j = l then (1 : ℝ) else 0) else 0)
    - (if i = l then (if j = k then (1 : ℝ) else 0) else 0)







end

end BookProof.FullQuadratic



/-!
# Unbounded quadratic-type perturbations on the Gauss–polynomial (Hermite) core

`CONSOLIDATED_PLAN.md` §10.6.1 target 4 asks for essential self-adjointness of the *sum*
`−Δ + V` on the Gauss–polynomial core of `L²(ℝᵈ)`.  What was available so far is
`BookProof.ChapterQgHermiteOscillatorEsa`: the harmonic (conformal-mode) Hamiltonian
`−Δ + ‖x‖²/4` is essentially self-adjoint on that core, and — by Kato–Rellich with relative
bound `0` — so is `−Δ + ‖x‖²/4 + B` for a *bounded* continuous `B`.  On the other side,
`BookProof.ChapterHermiteExpWall` shows that the exponentially growing scalaron wall is
**not** relatively bounded on this core at all, so no Kato–Rellich argument can reach it.

This module fills the gap in between: **unbounded** perturbations of quadratic type.

## The analytic input

The one quantitative fact needed is the relative bound of the harmonic potential itself with
respect to the harmonic Hamiltonian, with constant `1`:

`‖(‖x‖²/4)ψ‖² ≤ ‖(−Δ + ‖x‖²/4)ψ‖² + (d/2)‖ψ‖²`   (`norm_sq_harmPoly_mul_le`).

It comes from the anticommutator identity (`gaussInt_anticommutator`), which on the
Gauss–polynomial core is a purely algebraic computation with the twisted derivative
`coreD j = ∂ⱼ − xⱼ/2` and Gaussian integration by parts:

`⟪−Δψ, Wψ⟫ + ⟪Wψ, −Δψ⟫ = 2 ∑ⱼ ⟪∂ⱼψ, W ∂ⱼψ⟫ − (d/2)‖ψ‖²`,  `W = ‖x‖²/4`,

whose right-hand side is `≥ −(d/2)‖ψ‖²` because `W ≥ 0`.  (Classically this is
`{−Δ, W} = −ΔW + 2∑ⱼ(−∂ⱼ)W∂ⱼ` with `ΔW = d/2`.)

## What is proved

* `gaussInt_anticommutator`, `two_re_inner_kin_harm_ge`, `norm_sq_harmPoly_mul_le`,
  `norm_harmPoly_mul_le` — the relative bound of `‖x‖²/4` with respect to `−Δ + ‖x‖²/4`,
  with relative constant `1` and additive constant `√(d/2)`;
* `norm_potLp_le_of_le_harm` — the `L²` bound `‖Vψ‖ ≤ a‖Wψ‖ + b‖ψ‖` for a potential
  dominated pointwise by `a·‖x‖²/4 + b`;
* **`harmonic_add_subquadratic_essentiallySelfAdjoint`** — the headline: if `V` is
  continuous with `|V(x)| ≤ a‖x‖²/4 + b` and `a < 1`, then `−Δ + ‖x‖²/4 + V` is essentially
  self-adjoint on the Gauss–polynomial core.  The perturbation may be unbounded;
* `harmonic_add_subquadratic_stone_flow` — the self-adjoint realization and its unitary
  group, read off from essential self-adjointness;
* `quadraticGrowth_essentiallySelfAdjoint` — the criterion in growth form: a continuous
  potential `U` with `|U(x) − ‖x‖²/4| ≤ A‖x‖² + C‖x‖ + B` and `4A < 1`;
* `scaledHarmonic_essentiallySelfAdjoint` — `−Δ + λ‖x‖²/4` is essentially self-adjoint on the
  (fixed, width-one) Gauss core for every `λ ∈ (0, 2)`;
* **`confV_essentiallySelfAdjoint`** — the conformal-mode instance of §10.6.1 target 4: the
  regularized `R + αR²` conformal-mode Hamiltonian `−Δ + V₃`,
  `V₃(R_c) = −(M²/2)R_c + αR_c²`, is essentially self-adjoint on the Gauss core of `L²(ℝ)`
  for `0 < α < 1/2`, unconditionally (no finite-speed hypothesis), together with its Stone
  flow `confV_stone_flow`;
* **`sectorQuad_essentiallySelfAdjoint`** — the two-variable reduced `(R_c, φ)` sector with
  the scalaron wall replaced by a quadratic term, `V₃(R_c) + μφ²` on `L²(ℝ²)`, for
  `0 < α < 1/2` and `0 < μ < 1/2`, with `sectorQuad_stone_flow`;
  `tendsto_starobinskyV_div_sq` computes the curvature of the scalaron potential at its
  minimum, `V(φ)/φ² → M²/(24α)`, and `sectorHarmonicApprox_essentiallySelfAdjoint` is the
  sector statement at that physically natural value of `μ`, valid when `M² < 12α`.

**Honest boundary.**  The relative bound of `‖x‖²/4` against `−Δ + ‖x‖²/4` is exactly `1`, so
the Kato–Rellich window `a < 1` is the natural limit of this method: it reaches quadratic
potentials whose curvature is within a factor `2` of the width of the Gauss core (this is why
`confV_essentiallySelfAdjoint` carries `α < 1/2`; a different `α` is the same operator on a
Gauss core of a different width, which this module does not build), and every strictly
subquadratic perturbation of them.  It does not reach the exponential scalaron wall — nothing
can, on this core, by `BookProof.ChapterHermiteExpWall`.
-/

namespace BookProof.HermiteQuadraticEsa

open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

/-! ## 1. Algebraic preliminaries on the core -/







/-- Conjugation of coefficients is additive. -/
theorem cpoly_add (p q : MvPolynomial (Fin d) ℂ) : cpoly (p + q) = cpoly p + cpoly q := by
  simp [cpoly]











/-! ## 2. The relative bound of the harmonic potential -/







/-! ## 3. Potentials dominated by the harmonic one -/





/-! ## 4. The essential self-adjointness theorem -/





/-! ## 5. The criterion in growth form, and instances -/













/-! ## 6. The regularized conformal mode of the `R + αR²` Hamiltonian -/

















/-! ## 7. The reduced two-variable sector with a quadratic scalaron term

The reduced `(R_c, φ)` sector of the gauge-fixed `R + αR²` Hamiltonian carries the
conformal-mode parabola `V₃(R_c)` in the first variable and the scalaron potential `V(φ)` in
the second.  The scalaron wall itself is out of reach on this core
(`BookProof.ChapterHermiteExpWall`), but its *harmonic approximation at the minimum* is not:
`V` vanishes to second order at `φ = 0` with `V(φ)/φ² → M²/(24α)`
(`tendsto_starobinskyV_div_sq`), so the model potential `V₃(R_c) + μφ²` with
`μ = M²/(24α)` is the quadratic sector Hamiltonian.  Both variables are handled at once by
the two-dimensional criterion. -/





















end

end BookProof.HermiteQuadraticEsa



/-!
# The quadratic form of `−d²/dx² + V` is bounded below when `V` is

`BookProof/ChapterWallEsaBddBelow.lean` proves that `−d²/dx² + V` is essentially
self-adjoint on the compactly supported smooth core of `L²(ℝ)` for every smooth `V`
bounded below.  Its docstring promised, but did not supply, the packaging lemma that
the shift-invert schemes need: the *quadratic form* of that operator is bounded below
by the same constant.  This module supplies it.

The content is the one-dimensional Green identity on the compactly supported smooth
core,

  `⟪(−d²/dx² + V) f, f⟫ = ∫ |f'|² + ∫ V |f|²`,

which is integration by parts once — carried out here with the compact-support
integration-by-parts engine
`BookProof.SchrodingerCutoff.integral_deriv_eq_zero_of_hasCompactSupport`.  Both terms
on the right are real, the first is `≥ 0`, and the second is `≥ -c ‖f‖²` when `V ≥ -c`.

## Contents

* `SemiboundedBelowOn` — the quadratic form of an unbounded operator on a core is
  bounded below by `-c`.
* `integral_conj_neg_deriv2_mul` — the Green identity `∫ conj(−f'') f = ∫ |f'|²` for
  a compactly supported `C²` function on the line.
* `kinCcR_quadratic_form` / `opCc_quadratic_form` / `ccEquiv_norm_sq` — the three
  pieces of the pairing as ordinary integrals.
* **`wallHamBddBelow_semibounded`** — the promised lemma: if `V ≥ -c` then the
  quadratic form of `wallHam V hV` is bounded below by `-c`.
* `wallHam_nonneg_form` — the `c = 0` case: for `V ≥ 0` the form is non-negative.

The exponential wall `eˣ + e⁻ˣ` is handled in `BookProof/ChapterExpPotentialEsa.lean`
(`expPotential_semibounded`).
-/

namespace BookProof.WallEsaSemibounded

open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



/-! ## The Green identity on the compactly supported smooth core -/

/-- **Integration by parts once.**  For a compactly supported `C²` function on the line,
`∫ conj(−f'') f = ∫ |f'|²`.  Both sides are real; the statement is phrased in `ℂ` so it
can be substituted directly into an `L²` pairing. -/
theorem integral_conj_neg_deriv2_mul (f : ℝ → ℂ)
    (hf : ContDiff ℝ 2 f) (hs : HasCompactSupport f) :
    ∫ x, (starRingEnd ℂ) (-deriv (deriv f) x) * f x = ((∫ x, ‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
  have hfd : Differentiable ℝ f := hf.differentiable (by norm_num)
  have hf1 : ContDiff ℝ 1 (deriv f) := hf.deriv'
  have hf1d : Differentiable ℝ (deriv f) := hf1.differentiable one_ne_zero
  have h1 : ∀ x, HasDerivAt f (deriv f x) x := fun x => (hfd x).hasDerivAt
  have h2 : ∀ x, HasDerivAt (deriv f) (deriv (deriv f) x) x := fun x => (hf1d x).hasDerivAt
  have hcont0 : Continuous f := hfd.continuous
  have hcont1 : Continuous (deriv f) := hf1d.continuous
  have hcont2 : Continuous (deriv (deriv f)) := hf1.continuous_deriv le_rfl
  have hs1 : HasCompactSupport (deriv f) := hs.deriv
  -- the energy density and its derivative
  set g : ℝ → ℂ := fun x => (starRingEnd ℂ) (deriv f x) * f x with hgdef
  set g' : ℝ → ℂ := fun x =>
    (starRingEnd ℂ) (deriv (deriv f) x) * f x + ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) with hg'def
  have hgderiv : ∀ x, HasDerivAt g (g' x) x := by
    intro x
    have hstar : HasDerivAt (fun y => (starRingEnd ℂ) (deriv f y))
        ((starRingEnd ℂ) (deriv (deriv f) x)) x := (h2 x).star
    have hmul := hstar.mul (h1 x)
    have hsq : (starRingEnd ℂ) (deriv f x) * deriv f x = ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
      rw [Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]
    simpa [hgdef, hg'def, hsq] using hmul
  have hg'cont : Continuous g' := by
    simp only [hg'def]
    fun_prop
  have hgsupp : HasCompactSupport g := hs.mul_left
  have hzero : ∫ x, g' x = 0 :=
    BookProof.SchrodingerCutoff.integral_deriv_eq_zero_of_hasCompactSupport hgderiv hg'cont hgsupp
  -- split the integral
  have hIa : Integrable fun x => (starRingEnd ℂ) (deriv (deriv f) x) * f x :=
    (by fun_prop : Continuous fun x => (starRingEnd ℂ) (deriv (deriv f) x) * f x
      ).integrable_of_hasCompactSupport hs.mul_left
  have hIb : Integrable fun x => ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) :=
    (by fun_prop : Continuous fun x => ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)
      ).integrable_of_hasCompactSupport (by
        exact hs1.comp_left (g := fun z : ℂ => ((‖z‖ ^ 2 : ℝ) : ℂ)) (by simp))
  have hsplit : (∫ x, g' x)
      = (∫ x, (starRingEnd ℂ) (deriv (deriv f) x) * f x)
        + ∫ x, ((‖deriv f x‖ ^ 2 : ℝ) : ℂ) := by
    simp only [hg'def]
    exact integral_add hIa hIb
  rw [hsplit] at hzero
  have hreal : (∫ x, ((‖deriv f x‖ ^ 2 : ℝ) : ℂ)) = ((∫ x, ‖deriv f x‖ ^ 2 : ℝ) : ℂ) :=
    integral_complex_ofReal
  rw [hreal] at hzero
  have hneg : (∫ x, (starRingEnd ℂ) (-deriv (deriv f) x) * f x)
      = -∫ x, (starRingEnd ℂ) (deriv (deriv f) x) * f x := by
    rw [← integral_neg]
    refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
    simp
  rw [hneg]
  linear_combination -hzero

/-! ## The three pieces of the pairing -/



/-- The kinetic quadratic form on the compactly supported smooth core is the Dirichlet
energy. -/
theorem kinCcR_quadratic_form (f : ccSchwartz ℝ) :
    (inner ℂ (kinCcR (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 : ℝ) : ℂ) := by
  have hincl : Submodule.inclusion (ccDomain_le_schwartzDomain (E := ℝ)) (ccEquiv ℝ f)
      = schwartzEquiv ℝ (f : 𝓢(ℝ, ℂ)) := Subtype.ext rfl
  have hkin : kinCcR (ccEquiv ℝ f)
      = (kinOpR (f : 𝓢(ℝ, ℂ))).toLp 2 (volume : Measure ℝ) := by
    simp only [kinCcR, LinearMap.coe_comp, Function.comp_apply, hincl, opL2_apply]
  rw [hkin, ccEquiv_coe, inner_toLp_left]
  rw [show (∫ x, (starRingEnd ℂ) ((kinOpR (f : 𝓢(ℝ, ℂ))) x)
        * ((f : 𝓢(ℝ, ℂ)).toLp 2 (volume : Measure ℝ) : ℝ → ℂ) x)
      = ∫ x, (starRingEnd ℂ) (-deriv (deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ)) x)
          * ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x from ?_]
  · exact integral_conj_neg_deriv2_mul _ ((f : 𝓢(ℝ, ℂ)).smooth 2) f.2
  refine integral_congr_ae ?_
  filter_upwards [(f : 𝓢(ℝ, ℂ)).coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx, kinOpR_apply]

/-- The potential quadratic form on the compactly supported smooth core. -/
theorem opCc_quadratic_form (V : ℝ → ℝ) (hV : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V)
    (f : ccSchwartz ℝ) :
    (inner ℂ (opCc V hV (ccEquiv ℝ f))
        ((ccEquiv ℝ f : ccDomain ℝ) : Lp ℂ 2 (volume : Measure ℝ)) : ℂ)
      = ((∫ x, V x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by
  rw [opCc_apply, ccEquiv_coe, inner_toLp_left, ← integral_complex_ofReal]
  refine integral_congr_ae ?_
  filter_upwards [(f : 𝓢(ℝ, ℂ)).coeFn_toLp 2 (volume : Measure ℝ)] with x hx
  rw [hx]
  simp only [mulCc_apply, map_mul, Complex.conj_ofReal, Complex.ofReal_mul]
  rw [mul_assoc, Complex.normSq_eq_conj_mul_self.symm, Complex.sq_norm]



/-! ## The packaging lemma -/





end

end BookProof.WallEsaSemibounded



/-!
# Faris–Lavine on the outer Fock space: the lifted Friedrichs comparison operator

`BookProof.ChapterQgOuterFockEsa` proves that the full gauge-fixed gravity Hamiltonian is
essentially self-adjoint on the finite-particle core of the outer Fock space
`𝔉 = ⊕ₙ L²(ℝ^{84n})`, by the Carleman route sector by sector.  This module builds the
**Faris–Lavine apparatus on the outer Fock space itself**, with the comparison operator
that the strategy calls for: the Friedrichs extension of the positive one-particle
operator `N₁ = −Δ + ‖x‖²/4`, lifted to `𝔉`.

Theorem 1 of Faris–Lavine (`BookProof.ChapterFarisLavine`) needs exactly three things of
its comparison operator `N`: symmetry, positivity, and that `N + 1` maps the domain
**onto** the space — the one consequence of self-adjointness the argument uses.  The point
of this module is that all three survive the two constructions the strategy chains
together:

* **Friedrichs.**  `friedrichsComparison` packages the Friedrichs extension of
  `BookProof.ChapterFriedrichsExtension` as such a comparison operator: the extension is
  built there as `S⁻¹ − 1` for the resolvent `S = (P+1)⁻¹`, so `N + 1` is onto by
  construction.  `Comparison.selfAdjoint` shows conversely that these three properties
  *are* self-adjointness, so `Comparison.isPositiveSelfAdjointExtension` produces the
  project's `IsPositiveSelfAdjointExtension` predicate.
* **Lifting.**  `dsComparison` lifts a family of fibre comparison operators to the
  `ℓ²`-direct sum, on the maximal domain `dsDom`.  Symmetry and positivity are fibrewise
  (`dsCompOp_hasSum_quadForm`), and surjectivity of `N + 1` lifts because the fibre
  solutions obey `‖xᵢ‖ ≤ ‖(Nᵢ+1)xᵢ‖ = ‖fᵢ‖` (`norm_le_norm_shift`), so they are
  automatically square-summable (`dsCompOp_surj`).  This is the precise sense in which
  "the Friedrichs extension of the positive one-particle operator lifts to an operator on
  the outer Fock space".

## What is proved

* `Comparison`, `Comparison.selfAdjoint`, `Comparison.isPositiveSelfAdjointExtension`,
  `Comparison.essentiallySelfAdjointOn`, `Comparison.esa_self` — comparison operators and
  the Faris–Lavine criterion packaged with one; a comparison operator is essentially
  self-adjoint on its own domain (the case `H = N`, `c = 0`).
* `friedrichsComparison`, `friedrichsComparison_extends` — every densely defined positive
  symmetric operator has one, namely its Friedrichs extension.
* `dsDom`, `dsCompOp`, `dsComparison`, `dsCompOp_surj` — the lift to an `ℓ²`-direct sum.
* `dsFibOp`, `dsFibOp_symmetricOn`, `dsFibOp_hasSum_commForm`, `dsFibOp_commForm_le` — a
  fibrewise symmetric operator on the lifted domain, under a relative bound
  `‖Hᵢu‖ ≤ K‖(Nᵢ+1)u‖` uniform in the fibre; **the commutator form of the lift is the sum
  of the fibre commutator forms**, so the Faris–Lavine bound `±i[H,N] ≤ cN` lifts with the
  *same* constant `c`.
* `dsFibOp_essentiallySelfAdjointOn` — **Faris–Lavine on an `ℓ²`-direct sum**: uniform
  fibre data gives essential self-adjointness of the direct-sum operator on the lifted
  domain.
* `harmPosSym`, `harmFried`, `harmFried_isPositiveSelfAdjointExtension` — the positive
  one-particle gravity operator `N₁ = −Δ + ‖x‖²/4` and its Friedrichs extension.
* `qgOuterComparison`, `qgOuterFriedDom`, `qgOuterFriedN`, `qgOuterFriedN_surj`,
  `qgOuterCore_le_friedDom`, `qgOuterFriedN_isPositiveSelfAdjointExtension`,
  `qgOuterFriedN_esa` — **the lifted comparison operator on the outer Fock space**: it is
  a positive self-adjoint extension of the finite-particle-core operator `dΓ(N₁)`
  (`qgOuterN`), `𝑁 + 1` is onto `𝔉`, and it is essentially self-adjoint on its domain.
* `qgOuterFock_esa_farisLavine` — **the Faris–Lavine theorem for the gravity Hamiltonian
  on the outer Fock space**: given sector realizations of the `n`-particle Hamiltonians on
  the domain of the sector comparison operator that are symmetric, relatively bounded by
  `N + 1` and satisfy `±i[H,N] ≤ cN`, all with constants uniform in the particle number,
  the lifted Hamiltonian is essentially self-adjoint on the lifted domain and extends the
  outer Fock Hamiltonian `qgOuterHam` on the finite-particle core.

## Honest boundary

The sector data of `qgOuterFock_esa_farisLavine` are hypotheses, not theorems of this
module: extending the `n`-particle quadratic Hamiltonian from the Gauss–polynomial core to
the *whole* domain of the sector oscillator, with a relative bound and a commutator bound
whose constants do not degrade as the particle number grows, is a separate analytic step
(the Hermite matrix elements of `BookProof.FullQuadratic.fqOp_hermiteCore` are the natural
route to it) and is not carried out here.  What is unconditional here is everything about
the comparison operator — the Friedrichs extension, its lift, and the fact that
Faris–Lavine applies on the outer Fock space once the sector data are supplied, with the
same constant `c` — together with the observation that uniformity in the particle number
is the only thing the lift asks for.  The *unconditional* essential self-adjointness of
the gravity Hamiltonian on the finite-particle core is proved, by the independent Carleman
route, in `BookProof.ChapterQgOuterFockEsa` (`qgOuterFock_esa`).

Everything in this module is `sorry`-free and `axiom`-free.
-/

open scoped ENNReal

namespace BookProof.QgOuterFockFL

open BookProof.FarisLavine
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.HashimotoShiftInvert
open BookProof.HermiteProductCore

noncomputable section

/-! ## 1. Comparison operators for the Faris–Lavine criterion -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

/-- A positive symmetric operator obeys `‖x‖ ≤ ‖A x + x‖`: the shift `A + 1` is bounded
below, hence injective. -/
theorem norm_le_norm_shift {D : Submodule ℂ F} (A : D →ₗ[ℂ] F)
    (hpos : ∀ x : D, 0 ≤ quadForm A x) (x : D) : ‖(x : F)‖ ≤ ‖A x + (x : F)‖ := by
  have hre : ‖(x : F)‖ ^ 2 ≤ (inner ℂ (x : F) (A x + (x : F)) : ℂ).re := by
    rw [inner_add_right, Complex.add_re]
    have h1 : (inner ℂ (x : F) ((x : F)) : ℂ).re = ‖(x : F)‖ ^ 2 := by
      simpa using inner_self_eq_norm_sq (𝕜 := ℂ) (x : F)
    have h2 := hpos x
    rw [quadForm] at h2
    linarith
  have hcs : (inner ℂ (x : F) (A x + (x : F)) : ℂ).re ≤ ‖(x : F)‖ * ‖A x + (x : F)‖ := by
    calc (inner ℂ (x : F) (A x + (x : F)) : ℂ).re
        ≤ ‖(inner ℂ (x : F) (A x + (x : F)) : ℂ)‖ := Complex.re_le_norm _
      _ ≤ ‖(x : F)‖ * ‖A x + (x : F)‖ := norm_inner_le_norm _ _
  rcases eq_or_lt_of_le (norm_nonneg (x : F)) with h | h
  · rw [← h]; exact norm_nonneg _
  · nlinarith

/-- **A Faris–Lavine comparison operator**: a positive symmetric operator whose shift
`N + 1` maps the domain onto the whole space.  These are exactly the three properties of
the comparison operator that Theorem 1 of Faris–Lavine uses; by
`comparison_isPositiveSelfAdjointExtension` they say precisely that `N` is a positive
self-adjoint operator. -/
structure Comparison (F : Type*) [NormedAddCommGroup F] [InnerProductSpace ℂ F] where
  /-- The domain of the comparison operator. -/
  dom : Submodule ℂ F
  /-- The comparison operator. -/
  op : dom →ₗ[ℂ] F
  /-- It is symmetric. -/
  sym : SymmetricOn dom op
  /-- It is positive. -/
  pos : ∀ x : dom, 0 ≤ quadForm op x
  /-- `N + 1` maps the domain onto the space. -/
  surj : ∀ f : F, ∃ x : dom, op x + (x : F) = f









/-- **The Friedrichs extension is a Faris–Lavine comparison operator.**  Every densely
defined positive symmetric operator has one: the resolvent `S = (P+1)⁻¹` built in
`BookProof.ChapterFriedrichsExtension` inverts the shift by construction. -/
def friedrichsComparison [CompleteSpace F] (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    Comparison F where
  dom := LinearMap.range (friedrichsResolvent P : F →ₗ[ℂ] F)
  op := invShiftOperator (friedrichsResolvent P) (friedrichsResolvent_injective P hdense) 1
  sym := invShiftOperator_symmetricOn _ _ _ (friedrichsResolvent_isSelfAdjoint P)
  pos := invShiftOperator_quadForm_nonneg _ _ _ (friedrichsResolvent_pos P)
  surj := by
    intro f
    have hinj : Function.Injective (friedrichsResolvent P) :=
      friedrichsResolvent_injective P hdense
    refine ⟨⟨friedrichsResolvent P f, ⟨f, rfl⟩⟩, ?_⟩
    have hpre : preim (friedrichsResolvent P) ⟨friedrichsResolvent P f, ⟨f, rfl⟩⟩ = f :=
      preim_eq _ hinj _ rfl
    rw [invShiftOperator_apply, hpre]
    push_cast
    module



end Abstract

/-! ## 2. Lifting a comparison operator to an `ℓ²`-direct sum -/

section Lift

variable {ι : Type*} {G : ι → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)]













variable (C : ∀ i, Comparison (G i))























/-! ### The commutator form of a fibrewise operator -/

variable (H : ∀ i, (C i).dom →ₗ[ℂ] G i)



variable {C H}











end Lift

/-! ## 3. The quantum-gravity outer Fock space -/

































end

end BookProof.QgOuterFockFL



/-!
# From a graph core to the whole comparison domain

Theorem 1 of Faris–Lavine, as formalized in `BookProof.ChapterFarisLavine` and packaged
with a comparison operator in `BookProof.ChapterQgOuterFockFarisLavine`, wants the
Hamiltonian `H` defined on the **whole** domain `𝒟(N)` of the comparison operator.  A
concrete Hamiltonian, however, is handed to us on a small core — for the quantum-gravity
sectors, the Gauss–polynomial core of `L²(ℝᴰ)`, which is much smaller than the Friedrichs
domain of the oscillator.  This module closes that gap once and for all.

The mechanism is the relative bound itself.  If `‖H₀u‖ ≤ K‖(N+1)u‖` on the core `C₀`, then
`H₀ ∘ (N+1)|_{C₀}⁻¹` is a **bounded** operator on the range of `(N+1)|_{C₀}`; that range is
dense (`coreRange_dense`), so the bounded operator extends continuously to the whole space
(`extCLM`), and composing back with `N + 1` on `𝒟(N)` produces the extension `ext`.  The
extension automatically satisfies the *same* relative bound (`ext_norm_le`), restricts to
`H₀` on the core (`ext_core`), and — this is the point — inherits symmetry and the
Faris–Lavine commutator bound from the core, by approximating an arbitrary domain vector
in the graph norm of `N` (`gcSeq` and the continuity lemmas around it).

The hypothesis that makes the approximation available is `IsGraphCore`: every vector of
`𝒟(N)` is approximated by core vectors *together with* their images under `N`.

## What is proved

* `shiftOp`, `shiftOp_injective` — the shift `N + 1` of a comparison operator and its
  injectivity (a consequence of positivity);
* `commForm_congr`, `quadForm_congr` — the two Faris–Lavine forms depend only on the
  values of the operators, not on the domain they are presented on;
* `IsGraphCore` — a subspace of `𝒟(N)` dense in the graph norm of `N`;
* `CoreData` — the package: a comparison operator, a graph core, a symmetric operator on
  the core, and a relative bound `‖H₀u‖ ≤ K‖(N+1)u‖`;
* `CoreData.coreRange`, `coreRange_dense`, `coreEquiv`, `resolvedMap`, `resolvedCLM`,
  `extCLM` — the bounded-extension construction;
* **`CoreData.ext`**, `ext_core`, `ext_norm_le`, `ext_symmetricOn`, `ext_commForm_le` —
  the extension of the Hamiltonian to the whole comparison domain, with the relative
  bound, symmetry and the commutator bound all transported from the core with the *same*
  constants;
* **`CoreData.ext_essentiallySelfAdjointOn`** — Faris–Lavine for the extension: the
  Hamiltonian extended from a graph core is essentially self-adjoint on `𝒟(N)`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgOuterFockCoreFL

open BookProof.FarisLavine
open BookProof.QgOuterFockFL
open BookProof.YangMillsFriedrichs
open BookProof.EsaClosure
open BookProof.HermiteProductCore
open Filter Topology

noncomputable section

/-! ## 1. Extending a relatively bounded operator from a graph core -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- The shift `N + 1` of a comparison operator. -/
def shiftOp (C : Comparison F) : C.dom →ₗ[ℂ] F := C.op + C.dom.subtype

omit [CompleteSpace F] in
@[simp] theorem shiftOp_apply (C : Comparison F) (x : C.dom) :
    shiftOp C x = C.op x + (x : F) := rfl





omit [CompleteSpace F] in
theorem shiftOp_injective (C : Comparison F) : Function.Injective (shiftOp C) := by
  intro a b hab
  have hz : shiftOp C (a - b) = 0 := by rw [map_sub, hab, sub_self]
  have h := norm_le_norm_shift C.op C.pos (a - b)
  rw [← shiftOp_apply, hz, norm_zero] at h
  have h0 : ((a - b : C.dom) : F) = 0 := by
    have := norm_nonneg ((a - b : C.dom) : F)
    exact norm_le_zero_iff.mp h
  exact sub_eq_zero.mp (Subtype.ext (by simpa using h0))

/-- `C₀` is a **graph core** for the comparison operator `C`: it sits inside the domain and
every domain vector is approximated by a core vector simultaneously in the norm of `F` and
in the norm of its image under `N`. -/
structure IsGraphCore (C : Comparison F) (C₀ : Submodule ℂ F) : Prop where
  /-- The core sits inside the domain. -/
  le : C₀ ≤ C.dom
  /-- Approximation in the graph norm. -/
  approx : ∀ (x : C.dom) (ε : ℝ), 0 < ε → ∃ y : C.dom, (y : F) ∈ C₀ ∧
    ‖(y : F) - (x : F)‖ < ε ∧ ‖C.op y - C.op x‖ < ε

/-- The data needed to extend a symmetric operator from a graph core to the whole domain of
a comparison operator: a relative bound with respect to `N + 1`. -/
structure CoreData (F : Type*) [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    [CompleteSpace F] where
  /-- The comparison operator. -/
  C : Comparison F
  /-- The graph core. -/
  C₀ : Submodule ℂ F
  /-- The core is a graph core. -/
  gc : IsGraphCore C C₀
  /-- The operator, defined on the core only. -/
  H₀ : C₀ →ₗ[ℂ] F
  /-- The relative bound constant. -/
  K : ℝ
  /-- The relative bound constant is nonnegative. -/
  hK : 0 ≤ K
  /-- The relative bound `‖H₀ p‖ ≤ K‖(N + 1)p‖` on the core. -/
  rel : ∀ p : C₀, ‖H₀ p‖ ≤ K * ‖C.op ⟨(p : F), gc.le p.2⟩ + (p : F)‖

namespace CoreData

variable (d : CoreData F)





/-- The shift `N + 1` restricted to the core. -/
def coreShift : d.C₀ →ₗ[ℂ] F := (shiftOp d.C).comp (Submodule.inclusion d.gc.le)

@[simp] theorem coreShift_apply (p : d.C₀) :
    d.coreShift p = d.C.op ⟨(p : F), d.gc.le p.2⟩ + (p : F) := rfl

theorem coreShift_injective : Function.Injective d.coreShift := by
  intro a b hab
  have h1 : (Submodule.inclusion d.gc.le) a = (Submodule.inclusion d.gc.le) b :=
    shiftOp_injective d.C hab
  have h2 : (a : F) = (b : F) := by
    simpa using congrArg (fun z : d.C.dom => (z : F)) h1
  exact Subtype.ext h2

/-- The image of the core under `N + 1`. -/
def coreRange : Submodule ℂ F := LinearMap.range d.coreShift







/-- The core, identified with its image under `N + 1`. -/
def coreEquiv : d.C₀ ≃ₗ[ℂ] d.coreRange :=
  LinearEquiv.ofInjective _ d.coreShift_injective

@[simp] theorem coreEquiv_coe (p : d.C₀) : ((d.coreEquiv p : d.coreRange) : F) = d.coreShift p :=
  rfl

/-- `H₀ ∘ (N+1)⁻¹` on the image of the core: a *bounded* operator, by the relative bound. -/
def resolvedMap : d.coreRange →ₗ[ℂ] F := d.H₀.comp d.coreEquiv.symm.toLinearMap

theorem resolvedMap_bound (w : d.coreRange) : ‖d.resolvedMap w‖ ≤ d.K * ‖(w : F)‖ := by
  have h := d.rel (d.coreEquiv.symm w)
  have hw : d.coreShift (d.coreEquiv.symm w) = (w : F) := by
    rw [← coreEquiv_coe, LinearEquiv.apply_symm_apply]
  rw [← coreShift_apply, hw] at h
  exact h

/-- The bounded operator `H₀ ∘ (N+1)⁻¹`, on the dense subspace `(N+1)C₀`. -/
def resolvedCLM : d.coreRange →L[ℂ] F := d.resolvedMap.mkContinuous d.K d.resolvedMap_bound



/-- Its extension to the whole space, by density. -/
def extCLM : F →L[ℂ] F := d.resolvedCLM.extend d.coreRange.subtypeL



/-- **The extension of `H₀` from the graph core to the whole comparison domain.** -/
def ext : d.C.dom →ₗ[ℂ] F := (d.extCLM : F →ₗ[ℂ] F).comp (shiftOp d.C)







/-! ### Graph-core approximating sequences -/





















/-! ### The extension inherits symmetry and the commutator bound -/











end CoreData

end Abstract

end

end BookProof.QgOuterFockCoreFL



/-!
# The gravity Hamiltonian on the outer Fock space: Faris–Lavine with its own Friedrichs
extension

`BookProof.ChapterQgOuterFockFarisLavine` builds the Faris–Lavine apparatus on the outer
Fock space `𝔉 = ⊕ₙ L²(ℝ^{84n})`: a *comparison operator* is a positive symmetric operator
whose shift `N + 1` is onto (`Comparison`), the Friedrichs extension of any densely defined
positive symmetric operator is one (`friedrichsComparison`), and a family of fibre
comparison operators lifts to one on an `ℓ²`-direct sum (`dsComparison`).  That module then
lifts the one-particle oscillator `N₁ = −Δ + ‖x‖²/4` and leaves the sector data of the
gravity Hamiltonian as hypotheses.

This module removes the hypotheses in the case the Faris–Lavine strategy reaches
*unconditionally*: it takes the **gravity Hamiltonian itself** as the positive one-particle
operator.  The missing analytic ingredient is positivity of the sector Hamiltonian, which
is supplied here for every nonnegative signature.

## The positivity input

`BookProof.QgOuterFock.sqSumOp kappa v` is the operator `½ Σ_j κ_j π_j² + ½ Σ_r L_r²` on the
Gauss–polynomial core of `L²(ℝᴰ)`, for an arbitrary real signature `κ` and an arbitrary
finite family of real linear forms `L_r`.  Its quadratic form is
`½ Σ_j κ_j ‖π_j u‖² + ½ Σ_r ‖L_r u‖²`, because momentum and multiplication by a real
polynomial are Gauss-symmetric on the core; hence

`sqSumOp_quadForm_nonneg` : `0 ≤ κ` implies `0 ≤ ⟪ u, (sqSumOp κ v) u⟫`.

(The index set of the potential squares is an arbitrary finite type — the `n`-particle
gravity Hamiltonian needs `Fin n × Fin 64` — which is why this is proved here rather than
read off `BookProof.QuantumGravity3DGauge.signedOp_quadForm_nonneg`.)

## What is proved

* `quadForm_comp_self`, `quadForm_subtype_add`, `quadForm_subtype_real_smul`,
  `quadForm_subtype_sum`, `quadForm_sumSquares_nonneg` — the quadratic form of a sum of
  squares of symmetric operators with nonnegative weights is nonnegative.
* `momD`, `mulD`, `sqSumOp_eq_subtype_comp`, `sqSumOp_quadForm_nonneg` — the positivity
  input above.
* `dsFriedComparison`, `dsCore_le_dsFriedDom`,
  `dsFriedComparison_isPositiveSelfAdjointExtension`, `dsFriedComparison_esa` — **the
  general lift**: a family of densely defined positive symmetric operators, one per fibre,
  produces a Faris–Lavine comparison operator on the `ℓ²`-direct sum which is a positive
  self-adjoint extension of the direct sum of the fibre operators and is essentially
  self-adjoint on its domain.  This is the abstract form of “the Friedrichs extension of
  the positive one-particle operator lifts to the outer Fock space”.
* `kappaN`, `sectorHam`, `sectorHam_qgKappa`, `sectorHam_symmetricOn`,
  `sectorHam_quadForm_nonneg`, `sectorPosSym` — the `n`-particle gravity Hamiltonian
  `Σ_p h^{(p)}` of an arbitrary one-particle signature, and its positivity when the
  signature is nonnegative.
* `outerHam`, `outerHam_qgKappa`, `outerComparison`, `outer_esa_farisLavine`,
  `outer_isPositiveSelfAdjointExtension` — the outer Fock Hamiltonian of a nonnegative
  signature, its lifted Friedrichs comparison operator, and the two conclusions.
* `qgOuterEllipticHam`, `qgOuterEllipticComparison`, `qgOuterEllipticDom`,
  `qgOuterEllipticH`, **`qgOuterEllipticFock_esa_farisLavine`** — the physical instance:
  the elliptic-signature gravity Hamiltonian on the outer Fock space is essentially
  self-adjoint on the lifted Friedrichs domain, by Theorem 1 of Faris–Lavine with `c = 0`,
  and the lifted operator is a positive self-adjoint extension of `⊕ₙ Σ_p h^{(p)}` on the
  finite-particle core.

## Honest boundary

The signature must be **nonnegative**: this is the elliptic sector, `qgKappaElliptic`, not
the physical hyperbolic signature `qgKappa` (which is negative in the conformal direction,
`qgKappa_conformal_neg`), for which the sector Hamiltonian is not positive and has no
Friedrichs extension to lift.  For the physical signature the outer Fock space statement
that is proved is `BookProof.QgOuterFock.qgOuterFock_esa` — essential self-adjointness on
the *finite-particle core*, by the Carleman route sector by sector — and the Faris–Lavine
route stays conditional on the sector data of
`BookProof.QgOuterFockFL.qgOuterFock_esa_farisLavine`.  Nothing here claims a spectrum, a
mass gap or a continuum limit.

Everything in this module is `sorry`-free and `axiom`-free.
-/
namespace BookProof.QgOuterFockElliptic

open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QgOuterFockFL
open BookProof.FriedrichsExtension
open BookProof.YangMillsFriedrichs

noncomputable section

/-! ## 1. Positivity of a sum of squares with a nonnegative signature -/

section QuadForm

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}











end QuadForm

/-! ## 2. The `d`-dimensional sum-of-squares operator with a nonnegative signature -/

variable {D : ℕ}





/-- Multiplication by a polynomial, as an operator of the core into itself. -/
def mulD (f : MvPolynomial (Fin D) ℂ) :
    polyGaussCore (d := D) →ₗ[ℂ] polyGaussCore (d := D) :=
  coreOp (YangMillsHermite.mulOp f)













/-! ## 3. The Friedrichs lift of a family of positive symmetric operators -/

section GenericLift

variable {I : Type*} {G : I → Type*} [∀ i, NormedAddCommGroup (G i)]
  [∀ i, InnerProductSpace ℂ (G i)] [∀ i, CompleteSpace (G i)]









end GenericLift

/-! ## 4. The gravity Hamiltonian of a nonnegative signature on the outer Fock space -/

























/-! ## 5. The elliptic gravity Hamiltonian -/











end

end BookProof.QgOuterFockElliptic



/-!
# The scalaron fibre: the exponential wall as a Faris–Lavine comparison operator

This module prepares the *one-dimensional* input of the quantum-gravity Faris–Lavine
programme in the form the outer-Fock lift needs: the scalaron degree of freedom, carrying
the **full exponential** Einstein-frame potential (no Taylor expansion), realised as a
family of Faris–Lavine comparison operators

`h_s = −d²/dφ² + φ²/4 + V(φ) + s`,  `s ≥ 0`,

on `L²(ℝ)`, together with the estimates that make the fibre usable inside a lifted
Hamiltonian: everything is uniform in the shift `s`.

## What is proved

* `isGraphCore_of_esa` — an abstract and reusable step: if a symmetric operator `P` on a
  subspace `C₀` is essentially self-adjoint there, then `C₀` is a **graph core** for *every*
  comparison operator extending `P`.  (Density of the range of `P − i` is exactly the
  deficiency triviality, and `‖Nu − iu‖² = ‖Nu‖² + ‖u‖²` converts one approximation into a
  graph approximation.)  This is what lets the Friedrichs extension of a positive
  one-particle operator be used with the core-extension machinery of
  `BookProof.QgOuterFockCoreFL`.
* `integral_weight_re_secondDeriv` — the weighted integration-by-parts identity
  `∫ P·Re(conj u · u'') = −∫ P|u'|² + ½∫ P''|u|²` for compactly supported smooth `u`.
* `wallEnergy_identity` — the resulting energy identity
  `‖−u'' + P u‖² = ‖u''‖² + ‖P u‖² + 2∫P|u'|² − ∫P''|u|²`.
* `WallPot` — the data of an admissible wall: a smooth non-negative potential with
  `V'' ≤ C(V+1)`.  `starobinskyWall` is the Einstein-frame scalaron potential, which
  satisfies it (`starobinskyV_hess_le`).
* `fibHam`, `fibHam_symmetricOn`, `fibHam_quadForm`, `fibHam_pos`, `fibHam_esa` — the fibre
  Hamiltonian on the compactly supported smooth core, its quadratic form, positivity and
  essential self-adjointness.
* `fibHam_norm_bounds` (`norm_deriv2_le`, `norm_pot_mul_le`, `norm_coord_mul_le`,
  `norm_deriv_le`, `norm_le_shift`) — the relative bounds of the second derivative, of the
  potential, of `φ` and of `d/dφ` against `‖(h_s+1)u‖`, **with constants independent of the
  shift `s`**.
* `fibComparison` — the Friedrichs extension of `h_s` as a Faris–Lavine comparison
  operator, and `fibComparison_isGraphCore`, `fibComparison_core_apply`.
-/

namespace BookProof.ScalaronFiberFL

open MeasureTheory SchwartzMap
open BookProof.StrichartzWave
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallEsaSemibounded
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.SchrodingerCutoff BookProof.FriedrichsExtension

noncomputable section

/-! ## 1. A graph core from essential self-adjointness -/

section Abstract

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]





end Abstract

/-! ## 2. Integration by parts: the Wronskian identity on the line -/

section Wronskian



end Wronskian

/-! ## 3. The scalaron fibre operator -/

section Fibre

/-- The `L²` space of the scalaron fibre. -/
abbrev L2R := Lp ℂ 2 (volume : Measure ℝ)

/-- An **admissible wall**: a smooth non-negative potential on the line.  The Einstein-frame
scalaron potential of Starobinsky inflation, with the exponential kept in full and no
Taylor expansion, is one — see `starobinskyWall`. -/
structure WallPot where
  /-- The potential. -/
  V : ℝ → ℝ
  /-- It is smooth. -/
  smooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V
  /-- It is non-negative. -/
  nonneg : ∀ x, 0 ≤ V x

/-- **The scalaron wall**: the Einstein-frame Starobinsky potential
`M⁴/(16α)·(1 − exp(−√(2/3)·φ/M))²`, with the exponential in full. -/
def starobinskyWall (M alpha : ℝ) (halpha : 0 < alpha) : WallPot where
  V := BookProof.Starobinsky.starobinskyV M alpha
  smooth := BookProof.ScalaronEsa.contDiff_starobinskyV M alpha
  nonneg := fun phi => BookProof.Starobinsky.starobinskyV_nonneg halpha phi

namespace WallPot

variable (W : WallPot) (s : ℝ)

/-- The fibre potential `φ²/4 + V(φ) + s`. -/
def pot : ℝ → ℝ := fun x => x ^ 2 / 4 + (W.V x + s)

theorem pot_smooth : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (W.pot s) :=
  ((contDiff_id.pow 2).div_const 4).add (W.smooth.add contDiff_const)

theorem pot_nonneg (hs : 0 ≤ s) (x : ℝ) : 0 ≤ W.pot s x := by
  have h1 : (0 : ℝ) ≤ x ^ 2 / 4 := by positivity
  have h2 := W.nonneg x
  simp only [pot]
  linarith





/-- **The scalaron fibre Hamiltonian** `h_s = −d²/dφ² + φ²/4 + V(φ) + s`, on the compactly
supported smooth core of `L²(ℝ)`. -/
def ham : ccDomain ℝ →ₗ[ℂ] L2R := wallHam (W.pot s) (W.pot_smooth s)

theorem ham_symmetricOn : SymmetricOn (ccDomain ℝ) (W.ham s) :=
  wallHam_symmetricOn _ _



end WallPot

/-! ### The fibre operator on a core element, as a Schwartz function -/













/-! ### Integrals -/







/-! ### The quadratic form of the fibre Hamiltonian, and the uniform estimates -/



theorem ham_inner_self (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) :
    (inner ℂ (W.ham s (ccEquiv ℝ f)) ((ccEquiv ℝ f : ccDomain ℝ) : L2R) : ℂ)
      = (((∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2)
          + ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 : ℝ) : ℂ) := by
  have hk := kinCcR_quadratic_form f
  have hp := opCc_quadratic_form (W.pot s) (W.pot_smooth s) f
  change (inner ℂ ((kinCcR + opCc (W.pot s) (W.pot_smooth s)) (ccEquiv ℝ f))
    ((ccEquiv ℝ f : ccDomain ℝ) : L2R) : ℂ) = _
  rw [LinearMap.add_apply, inner_add_left, hk, hp]
  push_cast
  ring

/-- The quadratic form of `h_s` is the Dirichlet energy plus the potential energy. -/
theorem ham_quadForm (W : WallPot) (s : ℝ) (f : ccSchwartz ℝ) :
    quadForm (W.ham s) (ccEquiv ℝ f)
      = (∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2)
        + ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 := by
  have h := ham_inner_self W s f
  have hc : (inner ℂ ((ccEquiv ℝ f : ccDomain ℝ) : L2R) (W.ham s (ccEquiv ℝ f)) : ℂ)
      = (starRingEnd ℂ)
        (inner ℂ (W.ham s (ccEquiv ℝ f)) ((ccEquiv ℝ f : ccDomain ℝ) : L2R) : ℂ) :=
    (inner_conj_symm _ _).symm
  rw [quadForm, hc, h]
  simp

theorem integral_deriv_nonneg (f : ccSchwartz ℝ) :
    (0 : ℝ) ≤ ∫ x, ‖deriv ((f : 𝓢(ℝ, ℂ)) : ℝ → ℂ) x‖ ^ 2 :=
  integral_nonneg fun x => by positivity

/-- **The fibre Hamiltonian is positive** for `s ≥ 0`. -/
theorem ham_quadForm_nonneg (W : WallPot) (s : ℝ) (hs : 0 ≤ s) (u : ccDomain ℝ) :
    0 ≤ quadForm (W.ham s) u := by
  obtain ⟨f, rfl⟩ := (ccEquiv ℝ).surjective u
  rw [ham_quadForm]
  have h2 : (0 : ℝ) ≤ ∫ x, W.pot s x * ‖(f : 𝓢(ℝ, ℂ)) x‖ ^ 2 :=
    integral_nonneg fun x => mul_nonneg (W.pot_nonneg s hs x) (by positivity)
  have h1 := integral_deriv_nonneg f
  linarith













/-! ### The commutator of the fibre Hamiltonian with the scalaron field -/







/-! ### The fibre comparison operator -/

namespace WallPot

variable (W : WallPot) (s : ℝ) (hs : 0 ≤ s)

/-- The fibre Hamiltonian as a densely defined positive symmetric operator. -/
def posSym : PosSymOp L2R where
  dom := ccDomain ℝ
  op := W.ham s
  sym := W.ham_symmetricOn s
  pos := ham_quadForm_nonneg W s hs

/-- **The fibre comparison operator**: the Friedrichs extension of
`h_s = −d²/dφ² + φ²/4 + V(φ) + s`, a positive self-adjoint operator whose shift by one is
onto `L²(ℝ)`. -/
def comparison : Comparison L2R :=
  friedrichsComparison (W.posSym s hs) ccDomain_dense







end WallPot

end Fibre

end

end BookProof.ScalaronFiberFL



/-!
# The scalaron–vielbein quantum-gravity Hamiltonian on the outer Fock space

This module assembles the Faris–Lavine proof of essential self-adjointness of the full
quantum-gravity Hamiltonian in the representation the *scalaron* forces on us: the vielbein
sector in the occupation-number (mode) representation, the scalaron in position
representation carrying the **full exponential** Einstein-frame potential, with no Taylor
expansion and no relative-boundedness hypothesis on the wall.

The Hilbert space is the outer Fock space of the vielbein modes with values in the scalaron
line,

`𝓕 = ℓ²(ι ; L²(ℝ_φ))`,

`ι` the set of occupation-number configurations of the vielbein modes.  The comparison
operator is the `ℓ²`-lift of the Friedrichs extension of the positive one-particle operator

`N_a = −d²/dφ² + φ²/4 + V(φ) + σ_a`

on the fibre `a`, `σ_a ≥ 1` the vielbein energy of the configuration.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ScalaronOuterFockFL

open MeasureTheory SchwartzMap
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.QgOuterFockFL BookProof.QgOuterFockCoreFL
open BookProof.ScalaronFiberFL
open BookProof.WallEsaSemibounded

noncomputable section

/-! ## 0. Generic estimates for a positive symmetric operator and its shift -/

section Shift

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- The shift identity `‖Nu + u‖² = ‖Nu‖² + 2q(u) + ‖u‖²`. -/
theorem norm_shift_sq (N : D →ₗ[ℂ] F) (hsym : SymmetricOn D N) (u : D) :
    ‖N u + (u : F)‖ ^ 2 = ‖N u‖ ^ 2 + 2 * quadForm N u + ‖(u : F)‖ ^ 2 := by
  have h := norm_add_sq (𝕜 := ℂ) (N u) ((u : F))
  have hq : (inner ℂ (N u) (u : F) : ℂ).re = quadForm N u := by
    rw [quadForm, hsym u u]
  rw [h]
  simp only [RCLike.re_to_complex] at *
  rw [hq]









end Shift

/-! ## 0b. The fibre estimates, in terms of core vectors -/

section Fibre

variable (W : WallPot) (s : ℝ)



















/-! The three relative bounds against the shift `h_s + 1`, uniform in `s`. -/









end Fibre

variable {ι : Type*}



/-- **The mode data of the gauge-fixed quantum-gravity Hamiltonian.**

`sig` is the vielbein energy of an occupation configuration, `A` the (Hermitian) mode matrix
of all vielbein self-interactions — it acts as a scalar on the scalaron fibre — and `B` the
(Hermitian) mode matrix of the scalaron–vielbein coupling, which acts by multiplication by
the scalaron field `φ`.  The band structure `nbr` makes every row and column finite, and the
five bounds are the Faris–Lavine input: the vielbein matrix is allowed to grow like the mode
energy (as the second quantization of a quadratic Hamiltonian does), the coupling matrix is
required to be Schur-bounded. -/
structure QgModeData (ι : Type*) where
  /-- The vielbein energy of a mode configuration. -/
  sig : ι → ℝ
  /-- The energies are at least one. -/
  one_le_sig : ∀ a, 1 ≤ sig a
  /-- The vielbein self-interaction matrix. -/
  A : ι → ι → ℂ
  /-- The scalaron–vielbein coupling matrix. -/
  B : ι → ι → ℂ
  /-- The band. -/
  nbr : ι → Finset ι
  /-- The band is symmetric. -/
  mem_nbr_comm : ∀ a b, b ∈ nbr a ↔ a ∈ nbr b
  /-- `A` vanishes outside the band. -/
  A_off : ∀ a b, b ∉ nbr a → A a b = 0
  /-- `B` vanishes outside the band. -/
  B_off : ∀ a b, b ∉ nbr a → B a b = 0
  /-- `A` is Hermitian. -/
  A_herm : ∀ a b, A b a = (starRingEnd ℂ) (A a b)
  /-- `B` is Hermitian. -/
  B_herm : ∀ a b, B b a = (starRingEnd ℂ) (B a b)
  /-- The uniform bound. -/
  K : ℝ
  /-- The uniform bound is non-negative. -/
  K_nonneg : 0 ≤ K
  /-- Row bound for `A`, weighted by the mode energy. -/
  A_rel_row : ∀ a, ∑ b ∈ nbr a, ‖A a b‖ / sig b ≤ K
  /-- Column bound for `A`. -/
  A_rel_col : ∀ a, ∑ b ∈ nbr a, ‖A a b‖ ≤ K * sig a
  /-- Commutator bound for `A`. -/
  A_comm : ∀ a, ∑ b ∈ nbr a, |sig a - sig b| * ‖A a b‖ ≤ K * sig a
  /-- Schur bound for the coupling `B`. -/
  B_rel : ∀ a, ∑ b ∈ nbr a, ‖B a b‖ ≤ K
  /-- Commutator bound for the coupling `B`. -/
  B_comm : ∀ a, ∑ b ∈ nbr a, |sig a - sig b| * ‖B a b‖ ≤ K

namespace QgModeData

variable (Q : QgModeData ι)





end QgModeData

variable (W : WallPot) (Q : QgModeData ι)















/-! ## 2. The mode operators -/

























/-! ### Finite bands -/





/-! ### Inner products and norms as finite sums -/





/-! ## 3. The relative bound -/









/-! ### The three pieces of the Hamiltonian against the shift -/



















/-! ## 4. Symmetry -/











/-! ## 5. The commutator bound -/









/-! ## 6. The Faris–Lavine commutator bound -/







/-! ## 7. Essential self-adjointness of the full quantum-gravity Hamiltonian -/











end

end BookProof.ScalaronOuterFockFL



/-!
# The quantum-gravity Hamiltonian on a general spatial manifold

The earlier mode instances of this project fix the spatial manifold to a periodic box, so
that the modes are the Fourier modes and the momenta run over `ℤ³`
(`BookProof.ChapterQgContinuumModeInstance`).  Nothing in the Faris–Lavine analysis needs
that: in the **vielbein variables** the gravitational field is a global orthonormal coframe,
i.e. a triple of one-forms on the spatial slice, and the whole construction only sees

* the spectrum of the Laplace-type operator that defines the mode energies, and
* the fact that the torsion self-interaction `½ Σ ‖d e^i‖²` is **diagonal** in a mode basis
  adapted to the Hodge decomposition — `δd` acts as `0` on the closed part and as the Hodge
  eigenvalue on the co-closed part — together with the elementary bound `λ_a ≤ μ_a`.

Both are available on *any* closed Riemannian three-manifold that carries a global
orthonormal frame (every closed orientable three-manifold does), with *any* spectrum: no
periodicity, no lattice, no flatness, no bound on the eigenvalue multiplicities, no
homogeneity.  This module packages exactly that geometric input as
`VielbeinSpectrum` and shows it satisfies all five Faris–Lavine Schur bounds, so the whole
chain — essential self-adjointness, the mode cutoff, and the fully discrete Crank–Nicolson
evolution — holds verbatim on a general manifold.

## What is proved

* `VielbeinSpectrum` — the geometric mode data on a general spatial manifold: mode energies
  `μ_a ≥ 0` (the Laplace-type spectrum), the diagonal torsion eigenvalues `0 ≤ λ_a ≤ μ_a`
  (Hodge), the finite coupling block of each mode and the trace weights `|tr_a| ≤ 1` through
  which the scalaron couples, with the two Schur bounds on the blocks.
* `manifoldModes` — the resulting `QgModeData`, with Faris–Lavine constant `K = 1 + |g|·W`.
* **`qgManifold_essentiallySelfAdjointOn`**, **`starobinsky_qgManifold_esa`** — the
  quantum-gravity Hamiltonian on the outer Fock space over a general spatial manifold, with
  the full exponential Einstein-frame Starobinsky wall and arbitrary coupling constant, is
  essentially self-adjoint.
* `energyWindow`, `energyWindow_exhausts` — the **spectral cutoff** `μ_a ≤ n`, the general
  manifold's replacement for the momentum cutoff of the box.
* **`starobinsky_qgManifold_cutoff_flow_convergence`** — the spectrally truncated flows
  converge to the exact flow, uniformly on compact time intervals.
* **`starobinsky_qgManifold_fullyDiscrete_convergence`** — the fully discrete statement:
  spectral cutoff *and* Crank–Nicolson time stepping converge to the exact quantum-gravity
  flow.
* `ofSpectrumSeq` — non-vacuity with an *arbitrary* non-negative eigenvalue sequence: the
  instance does not constrain the geometry of the manifold through its spectrum.

Honest boundary: the geometric input (parallelizability, the Hodge decomposition of the
one-form modes, finiteness of the coupling blocks) enters as the data of
`VielbeinSpectrum`; the Riemannian geometry that produces it on a given manifold is not
itself formalized here.  No spectral information about the Hamiltonian, no mass gap and no
claim beyond the flow convergence is made.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgManifoldModeInstance

open Filter Topology
open BookProof.ChapterStoneResolvent
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgOuterFockCoreFL

noncomputable section

variable {ι : Type*}

/-! ## 1. The geometric mode data on a general spatial manifold -/

/-- **The vielbein mode spectrum of a general spatial manifold.**

`mu a` is the Laplace-type eigenvalue of the mode `a` (the mode energy is `σ_a = 1 + μ_a`);
`lam a` is the eigenvalue of the torsion form `δd` on that mode, which by the Hodge
decomposition is diagonal in this basis and bounded by `μ_a`; `block a` is the finite set of
modes the scalaron–vielbein coupling connects `a` to, and `tr a` is the trace weight of the
mode, through which the scalaron couples.  The two sums are the Schur bounds the
Faris–Lavine theorem needs; on the periodic box they hold with `W = 9`, on a general
manifold they hold whenever the coupling blocks are summable against the trace weights. -/
structure VielbeinSpectrum (ι : Type*) where
  /-- The Laplace-type eigenvalue of the mode. -/
  mu : ι → ℝ
  /-- The eigenvalues are non-negative. -/
  mu_nonneg : ∀ a, 0 ≤ mu a
  /-- The torsion (`δd`) eigenvalue of the mode. -/
  lam : ι → ℝ
  /-- Torsion eigenvalues are non-negative: `δd` is a positive operator. -/
  lam_nonneg : ∀ a, 0 ≤ lam a
  /-- Torsion eigenvalues are dominated by the Hodge eigenvalues. -/
  lam_le_mu : ∀ a, lam a ≤ mu a
  /-- The finite block of modes the scalaron coupling connects a mode to. -/
  block : ι → Finset ι
  /-- Blocks are symmetric. -/
  mem_block_comm : ∀ a b, b ∈ block a ↔ a ∈ block b
  /-- Every mode lies in its own block. -/
  self_mem_block : ∀ a, a ∈ block a
  /-- The trace weight of the mode. -/
  tr : ι → ℝ
  /-- The trace weights are normalized. -/
  abs_tr_le_one : ∀ a, |tr a| ≤ 1
  /-- The Schur constant of the coupling blocks. -/
  W : ℝ
  /-- The Schur constant is non-negative. -/
  W_nonneg : 0 ≤ W
  /-- Schur bound: the trace weights are summable across each block. -/
  tr_sum : ∀ a, ∑ b ∈ block a, |tr b| ≤ W
  /-- Schur bound for the commutator: the energy spread across a block, weighted by the
  trace weights, is bounded. -/
  tr_spread : ∀ a, ∑ b ∈ block a, |mu a - mu b| * |tr b| ≤ W

namespace VielbeinSpectrum

variable (S : VielbeinSpectrum ι)

/-- The mode energy `σ_a = 1 + μ_a`. -/
def sigOf (a : ι) : ℝ := 1 + S.mu a

theorem one_le_sigOf (a : ι) : 1 ≤ S.sigOf a := by
  have := S.mu_nonneg a
  simp only [sigOf]
  linarith

theorem lam_le_sigOf (a : ι) : S.lam a ≤ S.sigOf a := by
  have := S.lam_le_mu a
  simp only [sigOf]
  linarith

open Classical in
/-- **The vielbein self-interaction on a general manifold**: the torsion Gram matrix, which
the Hodge decomposition makes diagonal, with the `δd` eigenvalues on the diagonal. -/
def Amat (a b : ι) : ℂ := if a = b then ((S.lam a : ℝ) : ℂ) else 0

open Classical in
/-- **The scalaron–vielbein coupling on a general manifold** at coupling constant `g`: the
scalaron couples through the trace weights, inside the coupling blocks. -/
def Bmat (g : ℝ) (a b : ι) : ℂ :=
  if b ∈ S.block a then ((g * S.tr a * S.tr b : ℝ) : ℂ) else 0

theorem Amat_herm (a b : ι) : S.Amat b a = (starRingEnd ℂ) (S.Amat a b) := by
  classical
  by_cases h : a = b
  · subst h; simp [Amat, Complex.conj_ofReal]
  · simp [Amat, h, Ne.symm h]

theorem Bmat_herm (g : ℝ) (a b : ι) : S.Bmat g b a = (starRingEnd ℂ) (S.Bmat g a b) := by
  classical
  by_cases h : b ∈ S.block a
  · have h' : a ∈ S.block b := (S.mem_block_comm a b).mp h
    simp only [Bmat, if_pos h, if_pos h', Complex.conj_ofReal]
    norm_cast
    ring
  · have h' : a ∉ S.block b := fun hh => h ((S.mem_block_comm a b).mpr hh)
    simp [Bmat, h, h']

theorem norm_Amat_diag (a : ι) : ‖S.Amat a a‖ = S.lam a := by
  simp [Amat, abs_of_nonneg (S.lam_nonneg a)]

theorem Amat_off_diag {a b : ι} (h : a ≠ b) : S.Amat a b = 0 := by
  simp [Amat, h]

theorem norm_Bmat_le (g : ℝ) (a b : ι) : ‖S.Bmat g a b‖ ≤ |g| * |S.tr a| * |S.tr b| := by
  classical
  by_cases h : b ∈ S.block a
  · simp only [Bmat, if_pos h, Complex.norm_real, Real.norm_eq_abs, abs_mul]
    exact le_rfl
  · simp only [Bmat, if_neg h, norm_zero]
    positivity

/-- **The mode data of the quantum-gravity Hamiltonian on a general spatial manifold.** -/
def modes (g : ℝ) : QgModeData ι where
  sig := S.sigOf
  one_le_sig := S.one_le_sigOf
  A := S.Amat
  B := S.Bmat g
  nbr := S.block
  mem_nbr_comm := S.mem_block_comm
  A_off := by
    intro a b hb
    have hne : a ≠ b := by
      rintro rfl
      exact hb (S.self_mem_block a)
    exact S.Amat_off_diag hne
  B_off := by
    classical
    intro a b hb
    simp [Bmat, hb]
  A_herm := S.Amat_herm
  B_herm := S.Bmat_herm g
  K := 1 + |g| * S.W
  K_nonneg := by
    have hW := S.W_nonneg
    have : 0 ≤ |g| * S.W := mul_nonneg (abs_nonneg g) hW
    linarith
  A_rel_row := by
    intro a
    classical
    have hsum : ∑ b ∈ S.block a, ‖S.Amat a b‖ / S.sigOf b
        = ‖S.Amat a a‖ / S.sigOf a := by
      refine Finset.sum_eq_single a (fun b _ hb => ?_) (fun h => absurd (S.self_mem_block a) h)
      rw [S.Amat_off_diag (Ne.symm hb)]
      simp
    rw [hsum, S.norm_Amat_diag a]
    have h1 : S.lam a ≤ S.sigOf a := S.lam_le_sigOf a
    have h2 : (0 : ℝ) < S.sigOf a := lt_of_lt_of_le zero_lt_one (S.one_le_sigOf a)
    have h3 : S.lam a / S.sigOf a ≤ 1 := by
      rw [div_le_one h2]; exact h1
    have h4 : 0 ≤ |g| * S.W := mul_nonneg (abs_nonneg g) S.W_nonneg
    linarith
  A_rel_col := by
    intro a
    classical
    have hsum : ∑ b ∈ S.block a, ‖S.Amat a b‖ = ‖S.Amat a a‖ := by
      refine Finset.sum_eq_single a (fun b _ hb => ?_) (fun h => absurd (S.self_mem_block a) h)
      rw [S.Amat_off_diag (Ne.symm hb)]
      simp
    rw [hsum, S.norm_Amat_diag a]
    have h1 : S.lam a ≤ S.sigOf a := S.lam_le_sigOf a
    have h2 : (0 : ℝ) ≤ S.sigOf a := le_trans zero_le_one (S.one_le_sigOf a)
    have h4 : 0 ≤ |g| * S.W := mul_nonneg (abs_nonneg g) S.W_nonneg
    nlinarith
  A_comm := by
    intro a
    classical
    have hsum : ∑ b ∈ S.block a, |S.sigOf a - S.sigOf b| * ‖S.Amat a b‖ = 0 := by
      refine Finset.sum_eq_zero fun b _ => ?_
      by_cases hb : a = b
      · subst hb; simp
      · rw [S.Amat_off_diag hb]; simp
    rw [hsum]
    have h2 : (0 : ℝ) ≤ S.sigOf a := le_trans zero_le_one (S.one_le_sigOf a)
    have h4 : 0 ≤ |g| * S.W := mul_nonneg (abs_nonneg g) S.W_nonneg
    nlinarith
  B_rel := by
    intro a
    have hterm : ∀ b ∈ S.block a, ‖S.Bmat g a b‖ ≤ |g| * |S.tr b| := by
      intro b _
      refine le_trans (S.norm_Bmat_le g a b) ?_
      calc |g| * |S.tr a| * |S.tr b| ≤ |g| * 1 * |S.tr b| := by
            gcongr
            exact S.abs_tr_le_one a
        _ = |g| * |S.tr b| := by ring
    calc ∑ b ∈ S.block a, ‖S.Bmat g a b‖ ≤ ∑ b ∈ S.block a, |g| * |S.tr b| :=
          Finset.sum_le_sum hterm
      _ = |g| * ∑ b ∈ S.block a, |S.tr b| := by rw [Finset.mul_sum]
      _ ≤ |g| * S.W := by
          exact mul_le_mul_of_nonneg_left (S.tr_sum a) (abs_nonneg g)
      _ ≤ 1 + |g| * S.W := by linarith
  B_comm := by
    intro a
    have hterm : ∀ b ∈ S.block a, |S.sigOf a - S.sigOf b| * ‖S.Bmat g a b‖
        ≤ |g| * (|S.mu a - S.mu b| * |S.tr b|) := by
      intro b _
      have hsig : |S.sigOf a - S.sigOf b| = |S.mu a - S.mu b| := by
        simp only [sigOf]
        congr 1
        ring
      rw [hsig]
      have h5 : ‖S.Bmat g a b‖ ≤ |g| * |S.tr b| := by
        refine le_trans (S.norm_Bmat_le g a b) ?_
        calc |g| * |S.tr a| * |S.tr b| ≤ |g| * 1 * |S.tr b| := by
              gcongr
              exact S.abs_tr_le_one a
          _ = |g| * |S.tr b| := by ring
      calc |S.mu a - S.mu b| * ‖S.Bmat g a b‖
          ≤ |S.mu a - S.mu b| * (|g| * |S.tr b|) :=
            mul_le_mul_of_nonneg_left h5 (abs_nonneg _)
        _ = |g| * (|S.mu a - S.mu b| * |S.tr b|) := by ring
    calc ∑ b ∈ S.block a, |S.sigOf a - S.sigOf b| * ‖S.Bmat g a b‖
        ≤ ∑ b ∈ S.block a, |g| * (|S.mu a - S.mu b| * |S.tr b|) := Finset.sum_le_sum hterm
      _ = |g| * ∑ b ∈ S.block a, |S.mu a - S.mu b| * |S.tr b| := by rw [Finset.mul_sum]
      _ ≤ |g| * S.W := mul_le_mul_of_nonneg_left (S.tr_spread a) (abs_nonneg g)
      _ ≤ 1 + |g| * S.W := by linarith

/-! ## 2. The spectral cutoff -/





end VielbeinSpectrum

/-! ## 3. Essential self-adjointness on a general manifold -/





/-! ## 4. The spectrally truncated flows converge -/



/-! ## 5. The fully discrete evolution on a general manifold -/



/-! ## 6. Non-vacuity: an arbitrary spectrum is admissible -/





end

end BookProof.QgManifoldModeInstance



/-!
# A concrete gauge-fixed vielbein instance of the outer-Fock quantum-gravity Hamiltonian

`BookProof.ChapterScalaronOuterFockFL` proves essential self-adjointness of the full
quantum-gravity Hamiltonian on the outer Fock space `⊕_a L²(ℝ)` — the scalaron in vielbein
variables, with the full exponential Starobinsky wall and *all* interaction and coupling
terms — for an arbitrary `QgModeData`.  This module supplies the mode data, so that the
theorem is not conditional on an unmet hypothesis.

## What is proved

* `ofBounds` — the mode data assembled from elementary, checkable bounds: a Hermitian
  banded vielbein self-interaction `A` with `‖A a b‖ ≤ κ·min(σ_a, σ_b)`, a Hermitian banded
  scalaron–vielbein coupling `B` with `‖B a b‖ ≤ κ`, an energy spread `|σ_a − σ_b| ≤ κ`
  across the band and a bound `deg` on the band size; the Faris–Lavine constant is
  `K = deg·κ·(1 + κ)`.
* `ofFintype` — for a **finite** mode set (the gauge-fixed lattice truncation) *every*
  Hermitian pair `A`, `B` is admissible, with no smallness assumption whatsoever.
* `torsionForm`, `torsionGram` — the discrete torsion `∂_μ e_ν^a − ∂_ν e_μ^a` on the
  periodic three-dimensional spatial lattice, and the Gram matrix of all torsion terms:
  the complete vielbein self-interaction of the 3D gauge-fixed gravity Hamiltonian.
* `traceForm`, `scalaronCoupling` — the coupling of the scalaron to the trace of the
  vielbein.
* `qgLatticeModes` — the mode data of the 3D gauge-fixed vielbein lattice model.
* **`qgLattice_essentiallySelfAdjointOn`**, **`starobinsky_qgLattice_esa`** — essential
  self-adjointness of the resulting outer-Fock quantum-gravity Hamiltonian, the second with
  the Einstein-frame Starobinsky wall in its full exponential form.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QgVielbeinModeInstance

open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

variable {ι : Type*}

/-! ## 1. Mode data from elementary bounds -/





/-! ## 2. Finitely many modes: no smallness assumption at all -/

section Fintype

variable [Fintype ι] [DecidableEq ι]















end Fintype

/-! ## 3. The three-dimensional gauge-fixed vielbein lattice -/

section Lattice

variable (L : ℕ) [NeZero L]

/-- The sites of the periodic three-dimensional spatial lattice with `L` sites per
direction. -/
abbrev Site := Fin 3 → ZMod L



/-- The unit shift of a site in the direction `mu` (periodic boundary conditions). -/
def shift (mu : Fin 3) (s : Site L) : Site L := Function.update s mu (s mu + 1)





















end Lattice

end

end BookProof.QgVielbeinModeInstance

