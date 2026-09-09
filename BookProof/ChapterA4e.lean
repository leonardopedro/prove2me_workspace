import Mathlib
import BookProof.ChapterA5

/-!
# Chapter A, §A.4 — Props 88 / Corollary 1: the CPT / "antiparticle" payoff

Source: `book.tex` §A.4 (line 5636), Props 87–88 and Corollary 1 — the *causality
⇒ antiparticles* / CPT statement.

The book's argument (roadmap §A.4, "Localization: Props 87–88, Corollary 1") is
that the `iγ⁰`-energy-sign projectors are **not conserved** by the imprimitivity
(momentum → position) structure: the spatial-gradient coefficients `γʲγ⁰`
(the operators appearing in the energy symbol `iH = ∂⃗·γ⃗γ⁰ + …` of §A.5) do
**not** commute with `iγ⁰`.  Concretely `iγ⁰` *anticommutes* with each `γʲγ⁰`
(this is one of the generalized Clifford relations already established in
`ChapterA5`), so the two energy-sign projectors are *swapped* by every spatial
operator.  Hence:

* a positive-energy subspace is mapped onto the negative-energy one — **Prop 88**
  ("a localizable rep containing a positive-energy subrep also contains the
  negative-energy one", i.e. *antiparticles are forced*), and
* the `iγ⁰`-sign projectors are **not conserved**, so a full-Poincaré-irreducible
  localizable rep cannot use them — the reduction underlying **Corollary 1** (the
  CPT / position-operator payoff).

This file formalizes that concrete algebraic core on the `4×4` Majorana Clifford
model of §A.3/§A.5.  The energy operator `iγ⁰` squares to `-1`, so its
eigenvalues are `±i` and the sign projectors `P± = ½(1 ∓ i·iγ⁰)` live over `ℂ`
(they are genuine complementary projectors).  Everything reduces to the integer
anticommutation `{iγ⁰, γʲγ⁰} = 0` (`ChapterA5.coeffBoostZ_mass1_anticomm`) and is
`sorry`-free / `axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`),
with **no `EXTERNAL` hypothesis** (Wigner/Mackey enter only in the *exhaustiveness*
clauses of Props 87/88, which are the cited backbone, not this algebraic core).
-/

open Matrix

namespace BookProof.ChapterA4e

open BookProof.ChapterA3 BookProof.ChapterA5

/-! ## The energy operator and the spatial-gradient coefficients over `ℂ` -/

/-- The energy operator `iγ⁰` as a complex matrix (`= ChapterA3.mgamma 0`). -/
noncomputable def enSign : Matrix (Fin 4) (Fin 4) ℂ :=
  (Int.castRingHom ℂ).mapMatrix coeffMass1Z

/-- The spatial-gradient coefficient `γʲγ⁰` as a complex matrix
(`= ChapterA5.coeffBoostZ j` cast to `ℂ`). -/
noncomputable def spatialOp (j : Fin 3) : Matrix (Fin 4) (Fin 4) ℂ :=
  (Int.castRingHom ℂ).mapMatrix (coeffBoostZ j)

/-- `(iγ⁰)² = -1`: the energy operator squares to `-1`, so its eigenvalues are
`±i` and the sign projectors need complex coefficients. -/
theorem enSign_sq : enSign * enSign = -1 := by
  rw [enSign, ← map_mul, coeffMass1Z_sq, map_neg, map_one]

/-- The generalized Clifford relation `{iγ⁰, γʲγ⁰} = 0`: the energy operator
anticommutes with every spatial-gradient coefficient (this is the algebraic
heart of the non-conservation). -/
theorem enSign_spatialOp_anticomm (j : Fin 3) :
    enSign * spatialOp j + spatialOp j * enSign = 0 := by
  rw [enSign, spatialOp, ← map_mul, ← map_mul, ← map_add]
  rw [add_comm (coeffMass1Z * coeffBoostZ j) _, coeffBoostZ_mass1_anticomm, map_zero]

/-! ## The energy-sign projectors `P± = ½(1 ∓ i·iγ⁰)` -/

/-- The positive-energy-sign projector `P₊ = ½(1 - i·iγ⁰)`. -/
noncomputable def projPos : Matrix (Fin 4) (Fin 4) ℂ :=
  (2 : ℂ)⁻¹ • (1 - Complex.I • enSign)

/-- The negative-energy-sign projector `P₋ = ½(1 + i·iγ⁰)`. -/
noncomputable def projNeg : Matrix (Fin 4) (Fin 4) ℂ :=
  (2 : ℂ)⁻¹ • (1 + Complex.I • enSign)

/-
`P₊ + P₋ = 1`: the two energy-sign projectors are complementary.
-/
theorem projPos_add_projNeg : projPos + projNeg = 1 := by
  ext i j; simp [ projPos, projNeg ] ; ring

/-
`P₊² = P₊`: the positive-sign projector is idempotent.
-/
theorem projPos_idem : projPos * projPos = projPos := by
  have h : (Complex.I • enSign) * (Complex.I • enSign) = 1 := by
    rw [smul_mul_smul_comm, enSign_sq, Complex.I_mul_I, smul_neg, neg_smul,
      one_smul, neg_neg]
  have key : (1 - Complex.I • enSign) * (1 - Complex.I • enSign)
      = (2 : ℂ) • (1 - Complex.I • enSign) := by
    rw [sub_mul, mul_sub, mul_sub, one_mul, one_mul, mul_one, h]
    module
  rw [projPos, Matrix.smul_mul, Matrix.mul_smul, key, smul_smul, smul_smul]
  norm_num

/-
`P₋² = P₋`: the negative-sign projector is idempotent.
-/
theorem projNeg_idem : projNeg * projNeg = projNeg := by
  have h : (Complex.I • enSign) * (Complex.I • enSign) = 1 := by
    rw [smul_mul_smul_comm, enSign_sq, Complex.I_mul_I, smul_neg, neg_smul,
      one_smul, neg_neg]
  have key : (1 + Complex.I • enSign) * (1 + Complex.I • enSign)
      = (2 : ℂ) • (1 + Complex.I • enSign) := by
    rw [add_mul, mul_add, mul_add, one_mul, one_mul, mul_one, h]
    module
  rw [projNeg, Matrix.smul_mul, Matrix.mul_smul, key, smul_smul, smul_smul]
  norm_num

/-
`P₊ P₋ = 0`: the two energy-sign projectors are orthogonal.
-/
theorem projPos_mul_projNeg : projPos * projNeg = 0 := by
  have key : (1 - Complex.I • enSign) * (1 + Complex.I • enSign) = 0 := by
    have h : (Complex.I • enSign) * (Complex.I • enSign) = 1 := by
      rw [smul_mul_smul_comm, enSign_sq, Complex.I_mul_I, smul_neg, neg_smul,
        one_smul, neg_neg]
    rw [sub_mul, one_mul, mul_add, mul_one, h]
    abel
  rw [projPos, projNeg, Matrix.smul_mul, Matrix.mul_smul, key, smul_zero, smul_zero]

/-! ## The payoff: the spatial operators swap the two energy-sign subspaces -/

/-
**Prop 88 core.**  Every spatial-gradient operator `γʲγ⁰` *intertwines* the
positive- and negative-energy-sign projectors: `P₊ (γʲγ⁰) = (γʲγ⁰) P₋`.  Thus
`γʲγ⁰` maps the negative-energy subspace onto the positive-energy one — a
positive-energy subrep forces the corresponding negative-energy one
("antiparticles").
-/
theorem spatialOp_swaps_pos (j : Fin 3) :
    projPos * spatialOp j = spatialOp j * projNeg := by
  have hA : enSign * spatialOp j = -(spatialOp j * enSign) :=
    eq_neg_of_add_eq_zero_left (enSign_spatialOp_anticomm j)
  simp only [projPos, projNeg, Matrix.smul_mul, Matrix.mul_smul, sub_mul, mul_add,
    one_mul, mul_one]
  rw [hA]
  module

/-
Symmetrically, `P₋ (γʲγ⁰) = (γʲγ⁰) P₊`.
-/
theorem spatialOp_swaps_neg (j : Fin 3) :
    projNeg * spatialOp j = spatialOp j * projPos := by
  have hA : enSign * spatialOp j = -(spatialOp j * enSign) :=
    eq_neg_of_add_eq_zero_left (enSign_spatialOp_anticomm j)
  simp only [projPos, projNeg, Matrix.smul_mul, Matrix.mul_smul, add_mul, mul_sub,
    one_mul, mul_one]
  rw [hA]
  module

/-
The commutator of the positive-sign projector with a spatial operator equals
`i·(γʲγ⁰)(iγ⁰) = i·iγʲ`, an explicit nonzero matrix — the projector is *moved*.
-/
theorem projPos_spatialOp_commutator (j : Fin 3) :
    projPos * spatialOp j - spatialOp j * projPos
      = Complex.I • (spatialOp j * enSign) := by
  convert congr_arg ( fun x => x - spatialOp j * projPos ) ( spatialOp_swaps_pos j ) using 1;
  unfold projPos projNeg;
  norm_num [ mul_add, mul_sub, ← smul_assoc ];
  ext i j ; norm_num ; ring

/-
**Corollary 1 core: the energy-sign projectors are NOT conserved.**  There is
a spatial-gradient operator that does not commute with the positive-energy-sign
projector.  Hence a localizable representation that is irreducible under the full
Poincaré group cannot use the (non-conserved) `iγ⁰`-sign projectors — the
reduction underlying the CPT / position-operator payoff.
-/
theorem energy_sign_not_conserved :
    ∃ j : Fin 3, projPos * spatialOp j ≠ spatialOp j * projPos := by
  refine ⟨0, fun h => ?_⟩
  have hcomm : Complex.I • (spatialOp 0 * enSign) = 0 := by
    rw [← projPos_spatialOp_commutator 0, h, sub_self]
  have hM : spatialOp 0 * enSign = 0 :=
    (smul_eq_zero.mp hcomm).resolve_left Complex.I_ne_zero
  have hentry : (spatialOp 0 * enSign) 0 0 = 0 := by rw [hM]; rfl
  rw [spatialOp, enSign, ← map_mul, RingHom.mapMatrix_apply, Matrix.map_apply,
    eq_intCast, Int.cast_eq_zero] at hentry
  revert hentry
  decide

end BookProof.ChapterA4e
