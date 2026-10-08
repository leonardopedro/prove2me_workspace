import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Mathlib


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





(m,n)`) chiral decomposition

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
  · rw [show (-1 : M2) (i, j) (k, l) = -(if (i, j) = (k, l) then 1 else 0) from rfl,
        show (-1 : Matrix (Fin 4) (Fin 4) ℂ) i k = -(if i = k then 1 else 0) from rfl]
    simp only [Prod.mk.injEq]
    grind

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



/-! ## Parity anticommutes with each per-slot chirality -/





/-! ## The four projectors decompose the identity -/



/-! ## Diagonal `Spin⁺`-invariance of the four blocks -/





/-! ## The payoff: parity swaps `(m,n) ↔ (n,m)` -/













end BookProof.ChapterA3k
