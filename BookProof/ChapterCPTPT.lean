import Mathlib
import BookProof.ChapterCPTHamiltonian
import BookProof.ChapterCPTParity

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"Spinor frame and CPT theorem" — the Dirac mass Hamiltonian is PT (CPT) invariant

`book.tex` (§"Spinor frame and CPT theorem", line ~6453) states that the most general
mass Hamiltonian covariant under the connected component of the Lorentz group,

  `iH = ∂⃗·γ⃗ γ⁰ + i γ⁰ m₁ + γ⁰γ⁵ m₂`,

"is also **invariant under a parity–time reversal transformation (PT)**.  This is
essentially the **CPT theorem**, since CPT is a particular parity–time reversal
transformation."

The parity classification of the three building blocks was formalized in
`BookProof.ChapterCPTParity` (parity alone flips the sign of the `γ⁰γ⁵ m₂` term — the
parity-breaking term).  That file explicitly deferred the *full* PT statement to prose;
**this file discharges it** in the concrete `4×4` Majorana model of `BookProof.ChapterA3`,
using the Dirac Hamiltonian `diracHamOp` of `BookProof.ChapterCPTHamiltonian`.

## The PT transformation

The dynamics are `∂_t ψ = (iH) ψ`.  The PT transformation is the antiunitary map

  `ψ(t, x⃗)  ↦  γ⁵ · ψ*(-t, -x⃗)`

(complex conjugation `*` = time reversal `T`, together with the spatial reflection
`x⃗ ↦ -x⃗` = parity `P`, dressed by the chirality matrix `γ⁵`).  In plane-wave/momentum
form `∂ⱼ ↦ i kⱼ`, this decomposes into two ingredients:

* **T (complex conjugation).** In the Majorana basis the three building blocks
  `Kin j = γʲγ⁰`, `MassA = iγ⁰`, `MassB = γ⁰γ⁵` are all **real** matrices, so entrywise
  complex conjugation only flips the explicit `i` on the kinetic term:
  `conj_diracHamOp` : `conj (D(k, m₁, m₂)) = D(-k, m₁, m₂)`.

* **γ⁵ dressing.** The chirality matrix `γ⁵` **commutes** with the kinetic blocks and
  **anticommutes** with both mass blocks (`Kin_dgamma5_comm`, `MassA_dgamma5_anticomm`,
  `MassB_dgamma5_anticomm`), giving `pt_diracHamOp` : `D(k)·γ⁵ = -(γ⁵·D(-k))`.

Combining the two ingredients yields the single-equation headline

  `cpt_diracHamOp` : `γ⁵ · conj (D(k, m₁, m₂)) = -(D(k, m₁, m₂) · γ⁵)`,

i.e. the antiunitary map `ψ ↦ γ⁵ ψ*(-t,-x⃗)` maps solutions of `∂_t ψ = (iH)ψ` to
solutions — the Dirac mass Hamiltonian **including** the parity-breaking `m₂` term is PT
(CPT) invariant, even though parity `P` alone is broken by `m₂` (`ChapterCPTParity`).
This is the concrete content of the section's CPT-theorem remark.

This stays off the gravity line and off the Hankel-transform line, per the roadmap.
Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix

namespace BookProof.ChapterCPTPT

open BookProof.ChapterA3 BookProof.ChapterCPTHamiltonian

/-! ### Integer-model (anti)commutation of `iγ⁵` with the three building blocks -/

/-- Integer model: `iγ⁵` commutes with the kinetic blocks `Kin j = γʲγ⁰`. -/
theorem mgamma5Z_KinZ_comm (j : Fin 3) : mgamma5Z * KinZ j = KinZ j * mgamma5Z := by
  revert j; decide

/-- Integer model: `iγ⁵` anticommutes with the `m₁` mass block `MassA = iγ⁰`. -/
theorem mgamma5Z_MassAZ_anticomm : mgamma5Z * MassAZ + MassAZ * mgamma5Z = 0 := by decide

/-- Integer model: `iγ⁵` anticommutes with the `m₂` mass block `MassB = γ⁰γ⁵`. -/
theorem mgamma5Z_MassBZ_anticomm : mgamma5Z * MassBZ + MassBZ * mgamma5Z = 0 := by decide

/-! ### Complex-model (anti)commutation of `iγ⁵` with the three building blocks -/

/-- `iγ⁵` commutes with the kinetic blocks `Kin j`. -/
theorem mgamma5_Kin_comm (j : Fin 3) : mgamma5 * Kin j = Kin j * mgamma5 := by
  rw [mgamma5, Kin_eq_cast, ← map_mul, ← map_mul]
  congr 1
  exact mgamma5Z_KinZ_comm j

/-- `iγ⁵` anticommutes with the `m₁` mass block `MassA`. -/
theorem mgamma5_MassA_anticomm : mgamma5 * MassA + MassA * mgamma5 = 0 := by
  rw [mgamma5, MassA_eq_cast, ← map_mul, ← map_mul, ← map_add, mgamma5Z_MassAZ_anticomm,
    map_zero]

/-- `iγ⁵` anticommutes with the `m₂` mass block `MassB`. -/
theorem mgamma5_MassB_anticomm : mgamma5 * MassB + MassB * mgamma5 = 0 := by
  rw [mgamma5, MassB_eq_cast, ← map_mul, ← map_mul, ← map_add, mgamma5Z_MassBZ_anticomm,
    map_zero]

/-! ### (Anti)commutation of the Dirac `γ⁵ = -i (iγ⁵)` with the building blocks -/

/-- The chirality matrix `γ⁵` **commutes** with the kinetic blocks `Kin j = γʲγ⁰`. -/
theorem Kin_dgamma5_comm (j : Fin 3) : Kin j * dgamma5 = dgamma5 * Kin j := by
  rw [dgamma5, Matrix.mul_smul, Matrix.smul_mul, mgamma5_Kin_comm]

/-- The chirality matrix `γ⁵` **anticommutes** with the `m₁` mass block `MassA = iγ⁰`. -/
theorem MassA_dgamma5_anticomm : MassA * dgamma5 + dgamma5 * MassA = 0 := by
  rw [dgamma5, Matrix.mul_smul, Matrix.smul_mul, ← smul_add, add_comm (MassA * mgamma5),
    mgamma5_MassA_anticomm, smul_zero]

/-- The chirality matrix `γ⁵` **anticommutes** with the `m₂` mass block `MassB = γ⁰γ⁵`. -/
theorem MassB_dgamma5_anticomm : MassB * dgamma5 + dgamma5 * MassB = 0 := by
  rw [dgamma5, Matrix.mul_smul, Matrix.smul_mul, ← smul_add, add_comm (MassB * mgamma5),
    mgamma5_MassB_anticomm, smul_zero]

/-! ### The `γ⁵`-dressing part of PT: `D(k)·γ⁵ = -(γ⁵·D(-k))` -/

/-
**`γ⁵`-dressing part of PT.**  Because `γ⁵` commutes with the kinetic blocks and
anticommutes with both mass blocks,

  `D(k, m₁, m₂) · γ⁵ = -(γ⁵ · D(-k, m₁, m₂))`.

Together with the complex conjugation (`conj_diracHamOp`) this is the PT invariance.
-/
theorem pt_diracHamOp (k : Fin 3 → ℝ) (m1 m2 : ℝ) :
    diracHamOp k m1 m2 * dgamma5 = -(dgamma5 * diracHamOp (fun j => -(k j)) m1 m2) := by
  unfold diracHamOp;
  simp [ mul_add, add_mul, Finset.mul_sum _ _ _, Finset.sum_mul ];
  simp only [Kin_dgamma5_comm, eq_neg_of_add_eq_zero_left MassA_dgamma5_anticomm,
      eq_neg_of_add_eq_zero_left MassB_dgamma5_anticomm];
  module

/-! ### The time-reversal (complex-conjugation) part of PT -/

/-- Entrywise complex conjugation fixes the real (integer-cast) kinetic block `Kin j`. -/
theorem Kin_map_conj (j : Fin 3) : (Kin j).map (starRingEnd ℂ) = Kin j := by
  rw [Kin_eq_cast]
  ext a b
  simp [RingHom.mapMatrix_apply, Matrix.map_apply]

/-- Entrywise complex conjugation fixes the real (integer-cast) mass block `MassA`. -/
theorem MassA_map_conj : (MassA).map (starRingEnd ℂ) = MassA := by
  rw [MassA_eq_cast]
  ext a b
  simp [RingHom.mapMatrix_apply, Matrix.map_apply]

/-- Entrywise complex conjugation fixes the real (integer-cast) mass block `MassB`. -/
theorem MassB_map_conj : (MassB).map (starRingEnd ℂ) = MassB := by
  rw [MassB_eq_cast]
  ext a b
  simp [RingHom.mapMatrix_apply, Matrix.map_apply]

/-- **Time-reversal / complex-conjugation part of PT.**  The three building blocks are
real matrices, so entrywise complex conjugation of the Dirac Hamiltonian only flips the
explicit `i` on the kinetic term, i.e. it flips the momentum:

  `conj (D(k, m₁, m₂)) = D(-k, m₁, m₂)`. -/
theorem conj_diracHamOp (k : Fin 3 → ℝ) (m1 m2 : ℝ) :
    (diracHamOp k m1 m2).map (starRingEnd ℂ) = diracHamOp (fun j => -(k j)) m1 m2 := by
  unfold diracHamOp;
  simp only [Complex.coe_smul, map_add, implies_true, Matrix.map_add, Complex.real_smul, map_mul,
      Complex.conj_ofReal, Matrix.map_smul, Complex.ofReal_neg, neg_smul, Finset.sum_neg_distrib,
          smul_neg];
  rw [ MassA_map_conj, MassB_map_conj ];
  ext i j ; simp [ Complex.ext_iff ];
  simp [ Matrix.sum_apply, Kin_eq_cast ]

/-! ### Headline: the Dirac mass Hamiltonian is PT (CPT) invariant -/

/-- **PT (CPT) invariance of the Dirac mass Hamiltonian.**  Combining the time-reversal
part (`conj_diracHamOp`) with the `γ⁵`-dressing part (`pt_diracHamOp`),

  `γ⁵ · conj (D(k, m₁, m₂)) = -(D(k, m₁, m₂) · γ⁵)`.

Equivalently the antiunitary map `ψ(t,x⃗) ↦ γ⁵ ψ*(-t,-x⃗)` sends solutions of the Dirac
dynamics `∂_t ψ = (iH) ψ` to solutions: `iH` is invariant under the parity–time reversal
transformation.  Note this holds for **arbitrary** `m₂`, even though parity `P` alone is
broken by the `γ⁰γ⁵ m₂` term (`ChapterCPTParity.parity_diracHamOp`) — "this is
essentially the CPT theorem". -/
theorem cpt_diracHamOp (k : Fin 3 → ℝ) (m1 m2 : ℝ) :
    dgamma5 * (diracHamOp k m1 m2).map (starRingEnd ℂ)
      = -(diracHamOp k m1 m2 * dgamma5) := by
  rw [conj_diracHamOp, pt_diracHamOp, neg_neg]

end BookProof.ChapterCPTPT
