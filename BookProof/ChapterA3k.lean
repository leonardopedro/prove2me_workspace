import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3j

/-!
# Chapter A, §A.3 — Lemma 52: the tensor-power (`(m,n)`) chiral decomposition

Source: `book.tex` §A.3, Notes 50–51 and Lemma 52 (line ~5560).

`ChapterA3j` established the **base case** (`m = n = ½`, the Dirac spinor itself):
the chirality operator `iγ⁵` splits the spinor into the two Weyl subspaces
`V⁺_½, V⁻_½`, which are `Spin⁺(3,1)`-invariant but *swapped by parity*.

This file takes the **next step** of the classification: the *tensor-power*
mechanism.  Notes 50–51 build the general irreps `V_{(m,n)}` as symmetric tensor
powers of the two chiral spinors, and Lemma 52 observes that parity swaps
`V_{(m,n)} ↔ V_{(n,m)}`.  We formalize the first nontrivial tensor power — the
**two-fold tensor product** `V ⊗ V` (a `16`-dimensional space, modeled by the
Kronecker product of the `4×4` Majorana model of §A.3) — where the four
chirality blocks

* `V⁺ ⊗ V⁺` (label `(1,0)`), `V⁻ ⊗ V⁻` (label `(0,1)`),
* `V⁺ ⊗ V⁻` and `V⁻ ⊗ V⁺` (the mixed `(½,½)` blocks),

appear explicitly, and where the two structural facts of Lemma 52 already show up:

* **Diagonal `Spin⁺`-invariance.**  The two per-slot chirality operators
  `iγ⁵ ⊗ 1` and `1 ⊗ iγ⁵` each commute with the *diagonal* `Spin⁺` generator
  `γ^μγ^ν ⊗ 1 + 1 ⊗ γ^μγ^ν`, so all four chirality blocks are genuine
  subrepresentations of the (diagonally-acting) connected Lorentz group.
* **Parity glues `(m,n)` to `(n,m)`.**  The diagonal parity operator
  `γ⁰ ⊗ γ⁰` *anticommutes* with each per-slot chirality operator, hence it
  *intertwines* the blocks: it maps `V⁺⊗V⁺ ↔ V⁻⊗V⁻` (i.e. `(1,0) ↔ (0,1)`) and
  `V⁺⊗V⁻ ↔ V⁻⊗V⁺` (`(½,½)` to itself with the two factors swapped).  In
  particular the pure block `V⁺⊗V⁺` is **not** parity-invariant, so — exactly as
  in the base case — the real full-Lorentz irrep must combine `V_{(m,n)}` with
  its parity image `V_{(n,m)}`.

Everything is a Kronecker-algebra consequence of the base-case facts of
`ChapterA3j` and is `sorry`-free / `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`), with **no `EXTERNAL` hypothesis** (Note 50 /
Weyl complete reducibility and the extension to *arbitrary* `(m,n)` — general
`N`-fold symmetric powers — remain the cited backbone).
-/

open Matrix
open scoped Kronecker

namespace BookProof.ChapterA3k

open BookProof.ChapterA3 BookProof.ChapterA3j

/-- The `16`-dimensional carrier space `V ⊗ V` of two Dirac spinors, modeled as
`4×4 ⊗ 4×4` matrices via the Kronecker product. -/
abbrev M2 := Matrix (Fin 4 × Fin 4) (Fin 4 × Fin 4) ℂ

/-! ## The two per-slot chirality operators and the diagonal group action -/

/-- `iγ⁵` acting on the **first** tensor slot: `iγ⁵ ⊗ 1`. -/
noncomputable def chir1 : M2 := chir ⊗ₖ 1

/-- `iγ⁵` acting on the **second** tensor slot: `1 ⊗ iγ⁵`. -/
noncomputable def chir2 : M2 := 1 ⊗ₖ chir

/-- The **diagonal** `Spin⁺(3,1)` generator on `V ⊗ V`:
`γ^μγ^ν ⊗ 1 + 1 ⊗ γ^μγ^ν` (the infinitesimal Lorentz action on the tensor
product). -/
noncomputable def spinGenDiag (μ ν : Fin 4) : M2 :=
  spinGen μ ν ⊗ₖ 1 + 1 ⊗ₖ spinGen μ ν

/-- The **diagonal** parity operator on `V ⊗ V`: `γ⁰ ⊗ γ⁰`. -/
noncomputable def parityDiag : M2 := mgamma 0 ⊗ₖ mgamma 0

/-! ## The four chirality projectors -/

/-- `P_L ⊗ P_L` — the projector onto `V⁺ ⊗ V⁺` (label `(1,0)`). -/
noncomputable def projLL : M2 := projChirL ⊗ₖ projChirL
/-- `P_R ⊗ P_R` — the projector onto `V⁻ ⊗ V⁻` (label `(0,1)`). -/
noncomputable def projRR : M2 := projChirR ⊗ₖ projChirR
/-- `P_L ⊗ P_R` — projector onto the mixed block `V⁺ ⊗ V⁻`. -/
noncomputable def projLR : M2 := projChirL ⊗ₖ projChirR
/-- `P_R ⊗ P_L` — projector onto the mixed block `V⁻ ⊗ V⁺`. -/
noncomputable def projRL : M2 := projChirR ⊗ₖ projChirL

/-! ## Chirality operators square to `-1` and commute -/

theorem chir1_sq : chir1 * chir1 = -1 := by
  -- Unfold the definition of `chir1` as `chir ⊗ₖ 1`.
  unfold chir1;
  ext ⟨ i, j ⟩ ⟨ k, l ⟩ ; simp only [mul_apply, kroneckerMap_apply, neg_apply] ; ring;
  convert congr_arg ( fun m : Matrix ( Fin 4 ) ( Fin 4 ) ℂ => m i k * ( if j = l then 1 else 0 ) ) (
      BookProof.ChapterA3j.chir_sq ) using 1 <;> simp only [one_apply, mul_ite, mul_one, mul_zero,
          ite_mul, zero_mul, mul_apply, Prod.mk.injEq, neg_apply] ; focus (ring);
  · erw [ Finset.sum_product ] ; aesop;
  · grind

theorem chir2_sq : chir2 * chir2 = -1 := by
  unfold chir2;
  convert congr_arg ( fun x : Matrix ( Fin 4 ) ( Fin 4 ) ℂ => ( 1 : Matrix ( Fin 4 ) ( Fin 4 ) ℂ )
      ⊗ₖ x ) BookProof.ChapterA3j.chir_sq using 1;
  · ext i j; simp only [mul_apply, kroneckerMap_apply, one_apply, ite_mul, one_mul, zero_mul,
      mul_ite, mul_zero] ;
    split_ifs <;> simp_all only [↓reduceIte, Finset.sum_ite, Finset.sum_const_zero, add_zero,
        ite_self];
    refine Finset.sum_bij ( fun x hx => x.2 ) ?_ ?_ ?_ ?_ <;> aesop;
  · ext i j ; fin_cases i <;> fin_cases j <;> norm_num

/-- The two per-slot chirality operators commute (they act on different slots). -/
theorem chir1_chir2_comm : chir1 * chir2 = chir2 * chir1 := by
  unfold chir1 chir2;
  ext ⟨ i, j ⟩ ⟨ k, l ⟩ ; simp only [mul_apply, kroneckerMap_apply];
  erw [ Finset.sum_product ] ; erw [ Finset.sum_product ] ; ring;
  simp [ Matrix.one_apply, mul_comm ]

/-! ## Diagonal `Spin⁺`-invariance of the chirality operators -/

/--
`iγ⁵ ⊗ 1` commutes with the diagonal `Spin⁺` generator.
-/
theorem chir1_spinGenDiag_comm (μ ν : Fin 4) :
    chir1 * spinGenDiag μ ν = spinGenDiag μ ν * chir1 := by
      unfold spinGenDiag chir1;
      simp only [mul_add, add_mul, ← mul_kronecker_mul];
      simp [ BookProof.ChapterA3j.chir_spinGen_comm ]

/--
`1 ⊗ iγ⁵` commutes with the diagonal `Spin⁺` generator.
-/
theorem chir2_spinGenDiag_comm (μ ν : Fin 4) :
    chir2 * spinGenDiag μ ν = spinGenDiag μ ν * chir2 := by
  unfold chir2 spinGenDiag
  simp only [mul_add, add_mul, ← mul_kronecker_mul]
  simp [BookProof.ChapterA3j.chir_spinGen_comm]

/-! ## Parity anticommutes with each per-slot chirality -/

/-- `γ⁰ ⊗ γ⁰` anticommutes with `iγ⁵ ⊗ 1`. -/
theorem parity_chir1_anticomm : parityDiag * chir1 = -(chir1 * parityDiag) := by
  unfold parityDiag chir1
  rw [← mul_kronecker_mul, ← mul_kronecker_mul, one_mul, mul_one,
      BookProof.ChapterA3j.chir_parity_anticomm,
      ← neg_one_smul ℂ (mgamma 0 * chir), smul_kronecker]
  norm_num

/-- `γ⁰ ⊗ γ⁰` anticommutes with `1 ⊗ iγ⁵`. -/
theorem parity_chir2_anticomm : parityDiag * chir2 = -(chir2 * parityDiag) := by
  unfold parityDiag chir2
  rw [← mul_kronecker_mul, ← mul_kronecker_mul, mul_one, one_mul,
      BookProof.ChapterA3j.chir_parity_anticomm,
      ← neg_one_smul ℂ (mgamma 0 * chir), kronecker_smul]
  norm_num

/-! ## The four projectors decompose the identity -/

/--
The four chirality blocks are complementary: `P_LL + P_LR + P_RL + P_RR = 1`.
-/
theorem projSum : projLL + projLR + projRL + projRR = 1 := by
  -- Use the fact that `projChirL + projChirR = 1` to simplify the expression.
  have h_sum : (projChirL + projChirR) ⊗ₖ (projChirL + projChirR) = 1 := by
    rw [ BookProof.ChapterA3j.projChirL_add_projChirR ] ; aesop;
  convert h_sum using 1;
  ext; simp [ projLL, projLR, projRL, projRR ] ; ring;

/-! ## Diagonal `Spin⁺`-invariance of the four blocks -/

/--
`V⁺ ⊗ V⁺` is a diagonal-`Spin⁺` subrepresentation.
-/
theorem projLL_spinGenDiag_comm (μ ν : Fin 4) :
    projLL * spinGenDiag μ ν = spinGenDiag μ ν * projLL := by
      unfold projLL spinGenDiag;
      simp only [mul_add, ← mul_kronecker_mul, add_mul];
      rw [ BookProof.ChapterA3j.projChirL_spinGen_comm ];
      norm_num

/--
`V⁻ ⊗ V⁻` is a diagonal-`Spin⁺` subrepresentation.
-/
theorem projRR_spinGenDiag_comm (μ ν : Fin 4) :
    projRR * spinGenDiag μ ν = spinGenDiag μ ν * projRR := by
      unfold projRR spinGenDiag;
      simp only [mul_add, ← mul_kronecker_mul, add_mul];
      rw [ BookProof.ChapterA3j.projChirR_spinGen_comm ] ; norm_num

/-! ## The payoff: parity swaps `(m,n) ↔ (n,m)` -/

/--
**Lemma 52, tensor-power step.**  Diagonal parity intertwines the two pure
chirality blocks: `γ⁰⊗γ⁰` maps `V⁻⊗V⁻` onto `V⁺⊗V⁺`, i.e.
`(γ⁰⊗γ⁰) · P_RR = P_LL · (γ⁰⊗γ⁰)`.  Thus parity glues the `(1,0)` and `(0,1)`
reps together.
-/
theorem parity_swaps_LL_RR : parityDiag * projRR = projLL * parityDiag := by
  simp only [parityDiag, Fin.isValue, projRR, ← mul_kronecker_mul, projLL];
  rw [ BookProof.ChapterA3j.parity_swaps_chirL ]

/--
Symmetrically, parity maps `V⁺⊗V⁺` onto `V⁻⊗V⁻`.
-/
theorem parity_swaps_RR_LL : parityDiag * projLL = projRR * parityDiag := by
  simp only [parityDiag, Fin.isValue, projLL, ← mul_kronecker_mul, projRR]
  rw [BookProof.ChapterA3j.parity_swaps_chirR]

/--
Parity swaps the two mixed blocks `V⁺⊗V⁻ ↔ V⁻⊗V⁺`.
-/
theorem parity_swaps_LR_RL : parityDiag * projLR = projRL * parityDiag := by
  unfold parityDiag projLR projRL;
  simp only [← mul_kronecker_mul];
  rw [ BookProof.ChapterA3j.parity_swaps_chirR, BookProof.ChapterA3j.parity_swaps_chirL ]

/--
The diagonal parity operator is an involution: `(γ⁰⊗γ⁰)² = 1` (since
`(mgamma 0)² = -1` and `(-1)⊗(-1) = 1`).
-/
theorem parityDiag_sq : parityDiag * parityDiag = 1 := by
  have h_mgamma0_sq : mgamma 0 * mgamma 0 = -1 := by
    have h := mgamma_clifford 0 0
    norm_num [minkowski, minkowskiZ] at h
    linear_combination (norm := module) (2⁻¹ : ℂ) • h
  unfold parityDiag
  rw [← mul_kronecker_mul, h_mgamma0_sq,
      ← neg_one_smul ℂ (1 : Matrix (Fin 4) (Fin 4) ℂ),
      smul_kronecker, kronecker_smul, one_kronecker_one, smul_smul]
  norm_num

/--
The two pure chirality blocks are distinct projectors: `P_L⊗P_L ≠ P_R⊗P_R`.
-/
theorem projLL_ne_projRR : projLL ≠ projRR := by
  intro h
  have hentry := congr_fun (congr_fun h (0, 0)) (0, 1)
  unfold projLL projRR at hentry
  norm_num [projChirL, projChirR, chir, mgamma5, mgamma, mgammaZ] at hentry
  norm_num [Complex.ext_iff, mgamma5Z] at hentry

/--
**Lemma 52 headline (tensor-power step): the `(1,0)` block is not
parity-invariant.**  Diagonal parity does not commute with the projector onto
`V⁺⊗V⁺`; hence this pure-chirality `Spin⁺`-subrep is not irreducible under the
full Lorentz group, and the real full-Lorentz irrep must combine `V_{(m,n)}`
with its parity image `V_{(n,m)}` — the mechanism of Lemma 52, now at the level
of tensor powers.
-/
theorem projLL_not_parity_invariant :
    parityDiag * projLL ≠ projLL * parityDiag := by
  intro h
  have h_eq : projLL * parityDiag = projRR * parityDiag := by
    rw [← h, parity_swaps_RR_LL]
  apply_fun (· * parityDiag) at h_eq
  rw [mul_assoc, mul_assoc, parityDiag_sq, mul_one, mul_one] at h_eq
  exact projLL_ne_projRR h_eq

end BookProof.ChapterA3k
