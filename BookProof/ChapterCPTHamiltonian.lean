import Mathlib
import BookProof.ChapterA3

/-!
# Chapter "Real representations, CPT theorem …", §A.5 "Spinor frame and CPT theorem":
the most general Lorentz-covariant Dirac mass Hamiltonian and the mass-shell relation

This file formalizes the self-contained, finite-dimensional algebraic core of the
`book.tex` §A.5 subsection *"Spinor frame and CPT theorem"* (`book.tex` line ~6453).
There the author states that, in the space coordinates, the most general mass in the
Hamiltonian `iH` which is covariant under the connected component of the Lorentz group
is

  `iH = ∂⃗·γ⃗ γ⁰ + i γ⁰ m₁ + γ⁰ γ⁵ m₂`,

and observes that this operator is invariant under a parity–time reversal (PT)
transformation — "this is essentially the CPT theorem".

We work in the concrete `4×4` Majorana model of §A.3 (`BookProof.ChapterA3`), and
extract the two hard mathematical facts underlying the statement.  For a plane-wave
mode of spatial momentum `k⃗ = (k₀,k₁,k₂)` (so `∂ⱼ ↦ i kⱼ`), the operator becomes the
`4×4` complex matrix

  `D(k, m₁, m₂) = i (Σⱼ kⱼ γ^{j+1} γ⁰) + i m₁ γ⁰ + m₂ γ⁰ γ⁵`.

We prove:

* `diracHamOp_conjTranspose` — `Dᴴ = -D`, i.e. `iH` is **anti-Hermitian**, equivalently
  the Hamiltonian `H` is **Hermitian** (self-adjoint): the kinetic matrices `γʲγ⁰` are
  Hermitian and the two mass matrices `iγ⁰`, `γ⁰γ⁵` are anti-Hermitian, so `D = i H`
  with `H` self-adjoint.
* `diracHamOp_sq` — the **relativistic mass-shell / dispersion relation**
  `D² = -(k₀² + k₁² + k₂² + m₁² + m₂²) • 1`, i.e. the eigenvalues of `H` are
  `±√(k⃗² + m₁² + m₂²)`.  This is the algebraic reason the two mass parameters
  `m₁, m₂` are the "most general" covariant masses: the five matrices `γ¹γ⁰, γ²γ⁰,
  γ³γ⁰, iγ⁰, γ⁰γ⁵` are five **mutually anticommuting** operators whose squares are
  `+1, +1, +1, -1, -1`.

The underlying element-level Clifford identities are all reduced to the integer
matrix model of §A.3 and closed by `decide`; the surrounding physical modelling
(spinor frames, `Pin(3,1)` principal homogeneous space, field reparametrizations)
is left as prose.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix

namespace BookProof.ChapterCPTHamiltonian

open BookProof.ChapterA3

/-! ## 0. The Dirac `γ⁵` matrix -/

/-- The Dirac fifth matrix `γ⁵ = -i (iγ⁵)` (in line with `dgamma μ = -i (iγ^μ)`). -/
noncomputable def dgamma5 : Matrix (Fin 4) (Fin 4) ℂ := (-Complex.I) • mgamma5

/-! ## 1. Integer model of the five building-block matrices

All five matrices `γʲγ⁰`, `iγ⁰`, `γ⁰γ⁵` are *real* (they carry an even number of
`-i` factors), hence equal to the cast of an explicit integer matrix.  The whole
Clifford algebra of the five is closed by `decide` at the integer level. -/

/-- Kinetic block `γ^{j+1} γ⁰` at integer level: `γ^{j+1} γ⁰ = -(iγ^{j+1})(iγ⁰)`. -/
def KinZ (j : Fin 3) : Matrix (Fin 4) (Fin 4) ℤ := -(mgammaZ j.succ * mgammaZ 0)

/-- First mass block `iγ⁰` at integer level (equals `iγ⁰ = mgammaZ 0`). -/
def MassAZ : Matrix (Fin 4) (Fin 4) ℤ := mgammaZ 0

/-- Second mass block `γ⁰γ⁵` at integer level: `γ⁰γ⁵ = -(iγ⁰)(iγ⁵)`. -/
def MassBZ : Matrix (Fin 4) (Fin 4) ℤ := -(mgammaZ 0 * mgamma5Z)

theorem KinZ_sq (j : Fin 3) : KinZ j * KinZ j = 1 := by revert j; decide

theorem KinZ_anticomm (i j : Fin 3) (h : i ≠ j) :
    KinZ i * KinZ j + KinZ j * KinZ i = 0 := by revert i j; decide

theorem MassAZ_sq : MassAZ * MassAZ = -1 := by decide

theorem MassBZ_sq : MassBZ * MassBZ = -1 := by decide

theorem MassAZ_MassBZ_anticomm : MassAZ * MassBZ + MassBZ * MassAZ = 0 := by decide

theorem KinZ_MassAZ_anticomm (j : Fin 3) : KinZ j * MassAZ + MassAZ * KinZ j = 0 := by
  revert j; decide

theorem KinZ_MassBZ_anticomm (j : Fin 3) : KinZ j * MassBZ + MassBZ * KinZ j = 0 := by
  revert j; decide

theorem KinZ_transpose (j : Fin 3) : (KinZ j)ᵀ = KinZ j := by revert j; decide

theorem MassAZ_transpose : (MassAZ)ᵀ = -MassAZ := by decide

theorem MassBZ_transpose : (MassBZ)ᵀ = -MassBZ := by decide

/-! ## 2. The complex building blocks and the bridge to the integer model -/

/-- Kinetic block `γ^{j+1} γ⁰`. -/
noncomputable def Kin (j : Fin 3) : Matrix (Fin 4) (Fin 4) ℂ := dgamma j.succ * dgamma 0

/-- First mass block `iγ⁰`. -/
noncomputable def MassA : Matrix (Fin 4) (Fin 4) ℂ := Complex.I • dgamma 0

/-- Second mass block `γ⁰γ⁵`. -/
noncomputable def MassB : Matrix (Fin 4) (Fin 4) ℂ := dgamma 0 * dgamma5

/-- Conjugate-transpose of a real (integer-cast) matrix is the cast of its transpose. -/
theorem castMat_conjTranspose (M : Matrix (Fin 4) (Fin 4) ℤ) :
    ((Int.castRingHom ℂ).mapMatrix M)ᴴ = (Int.castRingHom ℂ).mapMatrix Mᵀ := by
  ext i j
  simp [RingHom.mapMatrix_apply, Matrix.map_apply, Matrix.conjTranspose_apply,
    Matrix.transpose_apply]

theorem Kin_eq_cast (j : Fin 3) :
    Kin j = (Int.castRingHom ℂ).mapMatrix (KinZ j) := by
  rw [Kin, dgamma, dgamma, KinZ, map_neg, map_mul, mgamma, mgamma]
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, neg_mul_neg, Complex.I_mul_I]
  simp

theorem MassA_eq_cast :
    MassA = (Int.castRingHom ℂ).mapMatrix MassAZ := by
  rw [MassA, dgamma, MassAZ, mgamma, smul_smul]
  simp

theorem MassB_eq_cast :
    MassB = (Int.castRingHom ℂ).mapMatrix MassBZ := by
  rw [MassB, dgamma, dgamma5, MassBZ, map_neg, map_mul, mgamma, mgamma5]
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul, neg_mul_neg, Complex.I_mul_I]
  simp

/-! ## 3. The Clifford algebra of the five blocks (complex level) -/

theorem Kin_sq (j : Fin 3) : Kin j * Kin j = 1 := by
  rw [Kin_eq_cast, ← map_mul, KinZ_sq, map_one]

theorem Kin_anticomm (i j : Fin 3) (h : i ≠ j) :
    Kin i * Kin j + Kin j * Kin i = 0 := by
  rw [Kin_eq_cast, Kin_eq_cast, ← map_mul, ← map_mul, ← map_add, KinZ_anticomm i j h, map_zero]

theorem MassA_sq : MassA * MassA = -1 := by
  rw [MassA_eq_cast, ← map_mul, MassAZ_sq, map_neg, map_one]

theorem MassB_sq : MassB * MassB = -1 := by
  rw [MassB_eq_cast, ← map_mul, MassBZ_sq, map_neg, map_one]

theorem MassA_MassB_anticomm : MassA * MassB + MassB * MassA = 0 := by
  rw [MassA_eq_cast, MassB_eq_cast, ← map_mul, ← map_mul, ← map_add,
    MassAZ_MassBZ_anticomm, map_zero]

theorem Kin_MassA_anticomm (j : Fin 3) : Kin j * MassA + MassA * Kin j = 0 := by
  rw [Kin_eq_cast, MassA_eq_cast, ← map_mul, ← map_mul, ← map_add,
    KinZ_MassAZ_anticomm j, map_zero]

theorem Kin_MassB_anticomm (j : Fin 3) : Kin j * MassB + MassB * Kin j = 0 := by
  rw [Kin_eq_cast, MassB_eq_cast, ← map_mul, ← map_mul, ← map_add,
    KinZ_MassBZ_anticomm j, map_zero]

/-! ## 4. Hermiticity of the blocks -/

/-- Each kinetic block `γʲγ⁰` is Hermitian. -/
theorem Kin_conjTranspose (j : Fin 3) : (Kin j)ᴴ = Kin j := by
  rw [Kin_eq_cast, castMat_conjTranspose, KinZ_transpose]

/-- The mass block `iγ⁰` is anti-Hermitian. -/
theorem MassA_conjTranspose : (MassA)ᴴ = -MassA := by
  rw [MassA_eq_cast, castMat_conjTranspose, MassAZ_transpose, map_neg]

/-- The mass block `γ⁰γ⁵` is anti-Hermitian. -/
theorem MassB_conjTranspose : (MassB)ᴴ = -MassB := by
  rw [MassB_eq_cast, castMat_conjTranspose, MassBZ_transpose, map_neg]

/-! ## 5. The Dirac Hamiltonian operator and its two headline properties -/

/-- The plane-wave form of the most general Lorentz-covariant Dirac mass Hamiltonian
`iH = ∂⃗·γ⃗ γ⁰ + i γ⁰ m₁ + γ⁰γ⁵ m₂` (with `∂ⱼ ↦ i kⱼ`):

`D(k, m₁, m₂) = i (Σⱼ kⱼ γ^{j+1}γ⁰) + i m₁ γ⁰ + m₂ γ⁰γ⁵`. -/
noncomputable def diracHamOp (k : Fin 3 → ℝ) (m1 m2 : ℝ) : Matrix (Fin 4) (Fin 4) ℂ :=
  Complex.I • (∑ j : Fin 3, (k j : ℂ) • Kin j)
    + (m1 : ℂ) • MassA
    + (m2 : ℂ) • MassB

/-- The momentum part `Σⱼ kⱼ γ^{j+1}γ⁰` is Hermitian. -/
theorem kinSum_conjTranspose (k : Fin 3 → ℝ) :
    (∑ j : Fin 3, (k j : ℂ) • Kin j)ᴴ = ∑ j : Fin 3, (k j : ℂ) • Kin j := by
  rw [Matrix.conjTranspose_sum]
  refine Finset.sum_congr rfl (fun j _ => ?_)
  rw [Matrix.conjTranspose_smul, Kin_conjTranspose, Complex.star_def, Complex.conj_ofReal]

/-- The momentum part squares to `(Σⱼ kⱼ²) • 1` (mutually anticommuting involutions). -/
theorem kinSum_sq (k : Fin 3 → ℝ) :
    (∑ j : Fin 3, (k j : ℂ) • Kin j) * (∑ j : Fin 3, (k j : ℂ) • Kin j)
      = (∑ j : Fin 3, (k j : ℂ) ^ 2) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  simp only [Complex.coe_smul, Fin.sum_univ_three, Fin.isValue]
  simp only [Fin.isValue, mul_add, Algebra.mul_smul_comm, add_mul, Algebra.smul_mul_assoc, smul_add,
      sq]
  simp only [Fin.isValue, Kin_sq, ← smul_assoc, smul_eq_mul]
  have h_anticomm :
      Kin 1 * Kin 0 + Kin 0 * Kin 1 = 0 ∧ Kin 2 * Kin 0 + Kin 0 * Kin 2 = 0 ∧
        Kin 2 * Kin 1 + Kin 1 * Kin 2 = 0 :=
    ⟨Kin_anticomm 1 0 (by decide), Kin_anticomm 2 0 (by decide), Kin_anticomm 2 1 (by decide)⟩
  simp_all only [Fin.isValue, ← eq_sub_iff_add_eq', zero_sub, ← ext_iff, neg_apply, smul_apply,
    Complex.real_smul, Complex.ofReal_mul, sub_apply, smul_eq_mul, add_apply, smul_neg]
  intro i j; ring

/-- The momentum part anticommutes with the mass block `iγ⁰`. -/
theorem kinSum_MassA_anticomm (k : Fin 3 → ℝ) :
    (∑ j : Fin 3, (k j : ℂ) • Kin j) * MassA + MassA * (∑ j : Fin 3, (k j : ℂ) • Kin j)
      = 0 := by
  rw [Finset.sum_mul, Finset.mul_sum, ← Finset.sum_add_distrib]
  exact Finset.sum_eq_zero fun i _ => by
    rw [Matrix.smul_mul, Matrix.mul_smul, ← smul_add, Kin_MassA_anticomm i, smul_zero]

/-- The momentum part anticommutes with the mass block `γ⁰γ⁵`. -/
theorem kinSum_MassB_anticomm (k : Fin 3 → ℝ) :
    (∑ j : Fin 3, (k j : ℂ) • Kin j) * MassB + MassB * (∑ j : Fin 3, (k j : ℂ) • Kin j)
      = 0 := by
  rw [Finset.sum_mul, Finset.mul_sum, ← Finset.sum_add_distrib]
  exact Finset.sum_eq_zero fun i _ => by
    rw [Matrix.smul_mul, Matrix.mul_smul, ← smul_add, Kin_MassB_anticomm i, smul_zero]

/-- **`iH` is anti-Hermitian**, i.e. the Hamiltonian `H` is self-adjoint. -/
theorem diracHamOp_conjTranspose (k : Fin 3 → ℝ) (m1 m2 : ℝ) :
    (diracHamOp k m1 m2)ᴴ = -diracHamOp k m1 m2 := by
  rw [diracHamOp, Matrix.conjTranspose_add, Matrix.conjTranspose_add,
    Matrix.conjTranspose_smul, Matrix.conjTranspose_smul, Matrix.conjTranspose_smul,
    kinSum_conjTranspose, MassA_conjTranspose, MassB_conjTranspose]
  have hI : star Complex.I = -Complex.I := by simp
  have hm1 : star (m1 : ℂ) = (m1 : ℂ) := by simp
  have hm2 : star (m2 : ℂ) = (m2 : ℂ) := by simp
  rw [hI, hm1, hm2]
  simp only [neg_smul, smul_neg]
  abel

/-
**The relativistic mass-shell / dispersion relation.**
`D² = -(k₀² + k₁² + k₂² + m₁² + m₂²) • 1`; the eigenvalues of the Hamiltonian `H` are
`±√(k⃗² + m₁² + m₂²)`, so `m₁, m₂` are exactly the covariant mass parameters.
-/
theorem diracHamOp_sq (k : Fin 3 → ℝ) (m1 m2 : ℝ) :
    diracHamOp k m1 m2 * diracHamOp k m1 m2
      = (-((∑ j : Fin 3, (k j : ℂ) ^ 2) + (m1 : ℂ) ^ 2 + (m2 : ℂ) ^ 2))
          • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  unfold diracHamOp Kin MassA MassB
  simp [Fin.sum_univ_three, dgamma, dgamma5]
  simp [mgamma, mgamma5]
  simp [mgammaZ, mgamma5Z]
  simp [← Matrix.ext_iff, Fin.forall_fin_succ, Matrix.mul_apply,
    Fin.sum_univ_succ] at *
  ring_nf
  norm_num [Complex.ext_iff, sq]
  ring

end BookProof.ChapterCPTHamiltonian
