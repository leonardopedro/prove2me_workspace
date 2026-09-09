import Mathlib
import BookProof.ChapterA3

/-!
# Chapter A, §A.3 — Notes 50–51 / Lemma 52: the chiral (`γ⁵`) decomposition core

Source: `book.tex` §A.3, Notes 50–51 and Lemma 52 (line ~5560) — the
classification of the finite-dimensional irreducible representations.

The book's finite-dim rep theory of `SL(2,ℂ)` / `Spin⁺(3,1)` is organized around
the chirality operator `γ⁵`:

* **Note 51 (complex irreps).**  The complex irreps `V_{(m,n)} = V⁺_m ⊗ V⁻_n` are
  built from symmetric tensor powers of the two `γ⁵`-eigenspaces (the Weyl / chiral
  Dirac spinors `V±`).  *Under parity* `V⁺_m ⊗ V⁻_n ↔ V⁻_m ⊗ V⁺_n`.
* **Lemma 52 (real irreps — the payoff).**  Unlike the complex irreps, the *real*
  irreps `W_{(m,n)}`, `m ≥ n`, are automatically projective reps of the **full**
  Lorentz group (invariant under parity and time reversal), because parity swaps
  the two chiralities and thus glues `V_{(m,n)}` to `V_{(n,m)}`.

This file formalizes the concrete algebraic **base case** of that structure —
the `γ⁵`-eigenspaces of the Dirac spinor itself (`m = n = ½`) — on the `4×4`
Majorana Clifford model of §A.3 (`ChapterA3`).  It is the exact chirality
analogue of the energy-sign story of `ChapterA4e`.  The chirality operator
`iγ⁵ = ChapterA3.mgamma5` squares to `-1` (`ChapterA3.mgamma5_sq`), so its
eigenvalues are `±i` and the chiral projectors `P_{L/R} = ½(1 ∓ i·iγ⁵)` live over
`ℂ`.

The two structural facts of Notes 50–51 / Lemma 52 that this concrete core
captures are:

* **Spin⁺-invariance of the chiral subspaces** (`projChirL_spinGen_comm` etc.):
  `iγ⁵` *commutes* with every even Clifford element `γ^μγ^ν` (the `Spin⁺(3,1)`
  generators), so the two chiral projectors commute with the whole connected
  Lorentz action — i.e. `V±` are genuine `Spin⁺` subrepresentations (the Weyl
  irreps `V⁺_½`, `V⁻_½`).
* **Parity swaps the chiralities** (`parity_swaps_chirL` / `parity_swaps_chirR`):
  `iγ⁵` *anticommutes* with `γ⁰` (the parity operator), so `γ⁰` *intertwines* the
  two chiral projectors, `P_L γ⁰ = γ⁰ P_R`.  Hence a single chirality is **not**
  preserved by the full Lorentz group (`chirality_not_parity_invariant`): the
  real full-Lorentz irrep must combine `V_{(m,n)}` with its parity image
  `V_{(n,m)}` — precisely the mechanism of Lemma 52.

Everything reduces to the integer Clifford relations of `ChapterA3` and is
`sorry`-free / `axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`),
with **no `EXTERNAL` hypothesis** (Note 50 / Weyl complete reducibility and the
symmetric-tensor-power generalization to arbitrary `(m,n)` remain the cited
backbone, not this algebraic base case).
-/

open Matrix

namespace BookProof.ChapterA3j

open BookProof.ChapterA3

/-! ## The chirality operator and the `Spin⁺` generators over `ℂ` -/

/-- The chirality operator `iγ⁵` as a complex matrix (`= ChapterA3.mgamma5`). -/
noncomputable def chir : Matrix (Fin 4) (Fin 4) ℂ := mgamma5

/-- The `Spin⁺(3,1)` generators `γ^μγ^ν` (the even Clifford elements): the
infinitesimal boosts (`μ,ν` mixed) and rotations act through these. -/
noncomputable def spinGen (μ ν : Fin 4) : Matrix (Fin 4) (Fin 4) ℂ :=
  mgamma μ * mgamma ν

/-- `(iγ⁵)² = -1`: the chirality operator squares to `-1`, so its eigenvalues are
`±i` and the chiral projectors need complex coefficients. -/
theorem chir_sq : chir * chir = -1 := by
  rw [chir, mgamma5_sq]

/-- `iγ⁵` anticommutes with each Majorana matrix `γ^μ`. -/
theorem chir_mgamma_anticomm (μ : Fin 4) :
    chir * mgamma μ = -(mgamma μ * chir) :=
  eq_neg_of_add_eq_zero_left (mgamma5_anticomm μ)

/-- **The chiral subspaces are `Spin⁺`-invariant.**  `iγ⁵` *commutes* with every
even Clifford element `γ^μγ^ν`; this is why `γ⁵` labels the connected-Lorentz
(Weyl) subrepresentations `V±`. -/
theorem chir_spinGen_comm (μ ν : Fin 4) :
    chir * spinGen μ ν = spinGen μ ν * chir := by
  rw [spinGen, ← mul_assoc, chir_mgamma_anticomm μ, neg_mul, mul_assoc,
    chir_mgamma_anticomm ν, mul_neg, neg_neg, mul_assoc]

/-- `iγ⁵` *anticommutes* with `γ⁰` (the parity operator): this is the special
case of `chir_mgamma_anticomm` that swaps the two chiralities. -/
theorem chir_parity_anticomm :
    chir * mgamma 0 = -(mgamma 0 * chir) :=
  chir_mgamma_anticomm 0

/-! ## The chiral projectors `P_{L/R} = ½(1 ∓ i·iγ⁵)` -/

/-- The left chiral projector `P_L = ½(1 - i·iγ⁵)`. -/
noncomputable def projChirL : Matrix (Fin 4) (Fin 4) ℂ :=
  (2 : ℂ)⁻¹ • (1 - Complex.I • chir)

/-- The right chiral projector `P_R = ½(1 + i·iγ⁵)`. -/
noncomputable def projChirR : Matrix (Fin 4) (Fin 4) ℂ :=
  (2 : ℂ)⁻¹ • (1 + Complex.I • chir)

/-- `P_L + P_R = 1`: the two chiral projectors are complementary. -/
theorem projChirL_add_projChirR : projChirL + projChirR = 1 := by
  ext i j; simp [projChirL, projChirR]; ring

/-- `P_L² = P_L`: the left chiral projector is idempotent. -/
theorem projChirL_idem : projChirL * projChirL = projChirL := by
  have h : (Complex.I • chir) * (Complex.I • chir) = 1 := by
    rw [smul_mul_smul_comm, chir_sq, Complex.I_mul_I, smul_neg, neg_smul,
      one_smul, neg_neg]
  have key : (1 - Complex.I • chir) * (1 - Complex.I • chir)
      = (2 : ℂ) • (1 - Complex.I • chir) := by
    rw [sub_mul, mul_sub, mul_sub, one_mul, one_mul, mul_one, h]
    module
  rw [projChirL, Matrix.smul_mul, Matrix.mul_smul, key, smul_smul, smul_smul]
  norm_num

/-- `P_R² = P_R`: the right chiral projector is idempotent. -/
theorem projChirR_idem : projChirR * projChirR = projChirR := by
  have h : (Complex.I • chir) * (Complex.I • chir) = 1 := by
    rw [smul_mul_smul_comm, chir_sq, Complex.I_mul_I, smul_neg, neg_smul,
      one_smul, neg_neg]
  have key : (1 + Complex.I • chir) * (1 + Complex.I • chir)
      = (2 : ℂ) • (1 + Complex.I • chir) := by
    rw [add_mul, mul_add, mul_add, one_mul, one_mul, mul_one, h]
    module
  rw [projChirR, Matrix.smul_mul, Matrix.mul_smul, key, smul_smul, smul_smul]
  norm_num

/-- `P_L P_R = 0`: the two chiral projectors are orthogonal. -/
theorem projChirL_mul_projChirR : projChirL * projChirR = 0 := by
  have key : (1 - Complex.I • chir) * (1 + Complex.I • chir) = 0 := by
    have h : (Complex.I • chir) * (Complex.I • chir) = 1 := by
      rw [smul_mul_smul_comm, chir_sq, Complex.I_mul_I, smul_neg, neg_smul,
        one_smul, neg_neg]
    rw [sub_mul, one_mul, mul_add, mul_one, h]
    abel
  rw [projChirL, projChirR, Matrix.smul_mul, Matrix.mul_smul, key, smul_zero,
    smul_zero]

/-! ## `Spin⁺`-invariance of the chiral projectors (the Weyl irreps `V±`) -/

/-- **Note 51 core: the chiral projectors are `Spin⁺`-invariant.**  Each chiral
projector *commutes* with every `Spin⁺(3,1)` generator `γ^μγ^ν`, so `V_L = P_L V`
and `V_R = P_R V` are genuine subrepresentations under the connected Lorentz
group — the Weyl / chiral irreps `V⁺_½`, `V⁻_½`. -/
theorem projChirL_spinGen_comm (μ ν : Fin 4) :
    projChirL * spinGen μ ν = spinGen μ ν * projChirL := by
  simp only [projChirL, Matrix.smul_mul, Matrix.mul_smul, sub_mul, mul_sub,
    one_mul, mul_one]
  rw [chir_spinGen_comm]

/-- Symmetrically, `P_R` commutes with every `Spin⁺` generator. -/
theorem projChirR_spinGen_comm (μ ν : Fin 4) :
    projChirR * spinGen μ ν = spinGen μ ν * projChirR := by
  simp only [projChirR, Matrix.smul_mul, Matrix.mul_smul, add_mul, mul_add,
    one_mul, mul_one]
  rw [chir_spinGen_comm]

/-! ## The payoff: parity swaps the two chiralities (Lemma 52) -/

/-- **Lemma 52 core.**  The parity operator `γ⁰` *intertwines* the two chiral
projectors: `P_L γ⁰ = γ⁰ P_R`.  Thus parity maps the right chiral subspace onto
the left one — `V_{(m,n)}` is glued to its parity image `V_{(n,m)}`, which is why
the real irreps of Lemma 52 are automatically full-Lorentz. -/
theorem parity_swaps_chirL :
    projChirL * mgamma 0 = mgamma 0 * projChirR := by
  simp only [projChirL, projChirR, Matrix.smul_mul, Matrix.mul_smul, sub_mul,
    mul_add, one_mul, mul_one]
  rw [chir_parity_anticomm]
  module

/-- Symmetrically, `P_R γ⁰ = γ⁰ P_L`. -/
theorem parity_swaps_chirR :
    projChirR * mgamma 0 = mgamma 0 * projChirL := by
  simp only [projChirL, projChirR, Matrix.smul_mul, Matrix.mul_smul, add_mul,
    mul_sub, one_mul, mul_one]
  rw [chir_parity_anticomm]
  module

/-- The commutator of the left chiral projector with parity equals
`i·γ⁰(iγ⁵)`, an explicit nonzero matrix — the chiral projector is *moved* by
parity. -/
theorem projChirL_parity_commutator :
    projChirL * mgamma 0 - mgamma 0 * projChirL
      = Complex.I • (mgamma 0 * chir) := by
  convert congr_arg (fun x => x - mgamma 0 * projChirL) parity_swaps_chirL using 1
  unfold projChirL projChirR
  norm_num [mul_add, mul_sub, ← smul_assoc]
  ext i j; norm_num; ring

/-- **Lemma 52 headline: chirality is NOT parity-invariant.**  There is a parity
operator (`γ⁰`) that does not commute with the left chiral projector.  Hence a
single-chirality `Spin⁺`-irrep is not irreducible under the *full* Lorentz group;
the real full-Lorentz irrep must combine `V_{(m,n)}` with its parity image
`V_{(n,m)}` — the mechanism underlying the classification of Lemma 52. -/
theorem chirality_not_parity_invariant :
    projChirL * mgamma 0 ≠ mgamma 0 * projChirL := by
  intro h
  have hcomm : Complex.I • (mgamma 0 * chir) = 0 := by
    rw [← projChirL_parity_commutator, h, sub_self]
  have hM : mgamma 0 * chir = 0 :=
    (smul_eq_zero.mp hcomm).resolve_left Complex.I_ne_zero
  have hentry : (mgamma 0 * chir) 0 3 = 0 := by rw [hM]; rfl
  rw [chir, mgamma, mgamma5, ← map_mul, RingHom.mapMatrix_apply, Matrix.map_apply,
    eq_intCast, Int.cast_eq_zero] at hentry
  revert hentry
  decide

end BookProof.ChapterA3j
