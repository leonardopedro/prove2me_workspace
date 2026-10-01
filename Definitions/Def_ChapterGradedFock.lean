import Definitions.Def_ChapterFermionFock
import Definitions.Def_ChapterSuperBracket
import Mathlib


/-!
# Chapter GradedFock — the graded Fock space `Γˢ ⊗ Γᵃ` and its superalgebra

`CONSOLIDATED_PLAN.md` §10.6.2 item 3 asks for the second quantization on the
**graded** Fock space `Γˢ ⊗ Γᵃ` "with the `ℤ₂`-graded superalgebra and the
fermionic CAR half".  `BookProof.ChapterFermionFock` supplies the fermionic half
`Γᵃ`; `BookProof.ChapterFockSecondQuantization` the bosonic half `Γˢ`; and
`BookProof.ChapterSuperBracket` the *abstract* super-bracket
`⟦a,b⟧ = ab − ε(p,q)·ba` together with the graded Jacobi identity.  This chapter
glues the three: it builds the graded Fock space over a product configuration
space and shows that the bosonic and fermionic creation/annihilation operators
living on it satisfy the book's **single unified graded relation**.

## Deliverables

* `otimes` — the elementary tensor `v ⊗ w` of finitely supported functions, with
  its bilinearity and `otimes_single`;
* `liftFst`, `liftSnd` — the two embeddings `T ↦ T ⊗ 1` and `S ↦ 1 ⊗ S` of the
  operator algebras of the factors into that of the product, together with the
  structural facts that make them algebra maps (`liftFst_mul`, `liftFst_one`,
  `liftFst_add`, `liftFst_sub`, …) and the key
  `liftFst_liftSnd_comm`: **operators on different tensor factors commute**;
* `GConf`, `GradedAlg`, `GFock` — the graded configuration space
  `Conf × FConf`, the algebraic graded Fock space and the Hilbert space
  `ℓ²(Conf × FConf) ≅ Γˢ ⊗ Γᵃ`;
* `bcre`, `bann`, `fcre`, `fann` — the bosonic (even) and fermionic (odd)
  creation and annihilation operators on the graded space;
* `super_canonical` — **the headline**: with the Koszul sign of
  `ChapterSuperBracket`,
  `⟦ a(p,j), a†(q,k) ⟧ = δ_{pq} δ_{jk}`,
  i.e. the *same* formula gives the bosonic **commutator** CCR, the fermionic
  **anticommutator** CAR, and the vanishing of the mixed brackets;
  `super_canonical_cre` and `super_canonical_ann` are its two companions;
* `gradeOp` — the `ℤ₂` grading operator `(−1)^{N_f}`: an involution
  (`gradeOp_involutive`) that commutes with the bosonic operators
  (`gradeOp_bcre`, `gradeOp_bann`) and anticommutes with the fermionic ones
  (`gradeOp_fcre`, `gradeOp_fann`);
* `evenPart`, `oddPart`, `even_add_odd`, `gradeOp_evenPart`, `gradeOp_oddPart` —
  the resulting `ℤ₂` decomposition `Γˢ ⊗ Γᵃ = (Γˢ ⊗ Γᵃ)₊ ⊕ (Γˢ ⊗ Γᵃ)₋`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.GradedFock

open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FockSecondQuantization BookProof.FermionFock
open BookProof.ChapterSuperBracket

noncomputable section

/-! ## Elementary tensors of finitely supported functions -/

section Tensor

variable {α β : Type*}

/-- The **elementary tensor** `v ⊗ w`, as a finitely supported function on the
product of the index types. -/
def otimes (v : α →₀ ℂ) (w : β →₀ ℂ) : (α × β) →₀ ℂ :=
  Finsupp.onFinset (v.support ×ˢ w.support) (fun p => v p.1 * w p.2) (by
    intro p hp
    rcases mul_ne_zero_iff.mp hp with ⟨h1, h2⟩
    exact Finset.mem_product.mpr
      ⟨Finsupp.mem_support_iff.mpr h1, Finsupp.mem_support_iff.mpr h2⟩)

























/-! ## Operators on one tensor factor -/

/-- `T ↦ T ⊗ 1`: an operator of the first factor, acting on the product. -/
def liftFst (T : (α →₀ ℂ) →ₗ[ℂ] (α →₀ ℂ)) : ((α × β) →₀ ℂ) →ₗ[ℂ] ((α × β) →₀ ℂ) :=
  Finsupp.lsum ℂ fun p => LinearMap.toSpanSingleton ℂ _
    (otimes (T (Finsupp.single p.1 1)) (Finsupp.single p.2 (1 : ℂ)))

/-- `S ↦ 1 ⊗ S`: an operator of the second factor, acting on the product. -/
def liftSnd (S : (β →₀ ℂ) →ₗ[ℂ] (β →₀ ℂ)) : ((α × β) →₀ ℂ) →ₗ[ℂ] ((α × β) →₀ ℂ) :=
  Finsupp.lsum ℂ fun p => LinearMap.toSpanSingleton ℂ _
    (otimes (Finsupp.single p.1 (1 : ℂ)) (S (Finsupp.single p.2 1)))









section Algebra

variable (T T' : Module.End ℂ (α →₀ ℂ)) (S S' : Module.End ℂ (β →₀ ℂ))



























end Algebra

end Tensor

/-! ## The graded Fock space -/

/-- A **graded configuration**: a bosonic occupation-number configuration
together with a fermionic occupied set. -/
abbrev GConf := Conf × FConf

/-- The **algebraic graded Fock space** `Γˢ ⊗ Γᵃ`. -/
abbrev GradedAlg := GConf →₀ ℂ

/-- The **graded Fock space** `ℓ²(Conf × FConf) ≅ Γˢ(ℓ²) ⊗ Γᵃ(ℓ²)`. -/
abbrev GFock := L2I GConf

/-- The bosonic (even) creation operator on the graded Fock space. -/
def bcre (j : ℕ) : Module.End ℂ GradedAlg := liftFst (creA j)

/-- The bosonic (even) annihilation operator on the graded Fock space. -/
def bann (j : ℕ) : Module.End ℂ GradedAlg := liftFst (annA j)

/-- The fermionic (odd) creation operator on the graded Fock space. -/
def fcre (j : ℕ) : Module.End ℂ GradedAlg := liftSnd (creF j)

/-- The fermionic (odd) annihilation operator on the graded Fock space. -/
def fann (j : ℕ) : Module.End ℂ GradedAlg := liftSnd (annF j)

/-! ### The canonical relations of the two factors, as operator identities -/

















/-! ### The unified graded canonical relation -/

/-- The annihilation operator of parity `p` (`false` = bosonic, `true` =
fermionic) and mode `j`. -/
def gAnn : Bool → ℕ → Module.End ℂ GradedAlg
  | false, j => bann j
  | true, j => fann j

/-- The creation operator of parity `p` and mode `j`. -/
def gCre : Bool → ℕ → Module.End ℂ GradedAlg
  | false, j => bcre j
  | true, j => fcre j











/-! ### The `ℤ₂` grading -/







/-- **The `ℤ₂` grading operator** `(−1)^{N_f}` of the graded Fock space: it acts
as the fermion-number parity on the antisymmetric factor and trivially on the
symmetric one. -/
def gradeOp : Module.End ℂ GradedAlg := liftSnd parityF











/-- The even part of a graded state. -/
def evenPart (u : GradedAlg) : GradedAlg := (2 : ℂ)⁻¹ • (u + gradeOp u)

/-- The odd part of a graded state. -/
def oddPart (u : GradedAlg) : GradedAlg := (2 : ℂ)⁻¹ • (u - gradeOp u)







end

end BookProof.GradedFock
