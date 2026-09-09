import Mathlib
import BookProof.ChapterCPTHamiltonian

/-!
# Chapter "Real representations, CPT theorem and the relativistic position operator",
§"Spinor frame and CPT theorem" — the parity classification of the Dirac mass Hamiltonian

`book.tex` (§"Spinor frame and CPT theorem", line ~6453) states that the most general
mass in the Hamiltonian `iH` covariant under the connected component of the Lorentz group
is

  `iH = ∂⃗·γ⃗ γ⁰ + i γ⁰ m₁ + γ⁰γ⁵ m₂`,

and observes that "we just need to define all the fields ... to check if the **parity
breaking term** can be absorbed by a reparametrization in which case we do not have parity
violation (which is often called CP violation ...)".

This file isolates the exact algebraic content of that remark in the concrete `4×4`
Majorana model of `BookProof.ChapterA3` (`M_μ = iγ^μ`), building on the Hamiltonian
`diracHamOp` of `BookProof.ChapterCPTHamiltonian`.  The parity operation on Majorana
spinors is the **spatial reflection** `x⃗ ↦ -x⃗` (so the plane-wave momentum flips,
`k⃗ ↦ -k⃗`) together with conjugation of the spinor by the Majorana parity matrix
`P = iγ⁰ = mgamma 0` (see `BookProof.ChapterParity`; `P² = -1`, so `P⁻¹ = -P`).

Applying that operation to each of the three building blocks of `iH` classifies them by
parity:

* `parity_Kin` — the kinetic matrices `Kin j = γʲγ⁰` are **parity-odd**
  (`P (Kin j) P⁻¹ = -Kin j`); combined with the momentum flip `kⱼ ↦ -kⱼ` the whole
  kinetic term is **parity-even** (invariant).
* `parity_MassA` — the `m₁` mass matrix `MassA = iγ⁰` is **parity-even**
  (`P (MassA) P⁻¹ = MassA`): the `iγ⁰ m₁` mass conserves parity.
* `parity_MassB` — the `m₂` mass matrix `MassB = γ⁰γ⁵` is **parity-odd**
  (`P (MassB) P⁻¹ = -MassB`): this is exactly the book's **parity-breaking term**.

Assembling these gives the headline

  `parity_diracHamOp` : `P · D(-k, m₁, m₂) · P⁻¹ = D(k, m₁, -m₂)`,

i.e. under a parity (spatial-reflection) transformation the Dirac Hamiltonian is mapped
to the same Hamiltonian with `m₂ ↦ -m₂`.  Hence (corollary `parity_diracHamOp_invariant`)
a Hamiltonian with `m₂ = 0` is exactly parity-invariant, while a nonzero `m₂` is the sole
source of parity (CP) violation — the CPT-theorem discussion of the section.

The book's further claim that `iH` (including the `m₂` term) is invariant under the full
parity–time-reversal transformation PT ("this is essentially the CPT theorem") is an
antiunitary statement about the field representation and is left as prose; this file
formalizes the concrete, decidable parity classification that underlies it.

This stays off the gravity line and off the Hankel-transform line, per the roadmap.
Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Matrix

namespace BookProof.ChapterCPTParity

open BookProof.ChapterA3 BookProof.ChapterCPTHamiltonian

/-! ### The Majorana parity operator `P = iγ⁰` and its inverse -/

/-- The Majorana parity matrix `P = iγ⁰ = mgamma 0` squares to `-1`, hence `-P` is its
inverse: `P · (-P) = 1`. -/
theorem parity_mul_neg_self : mgamma 0 * (-mgamma 0) = 1 := by
  have h := congrArg (Int.castRingHom ℂ).mapMatrix
    (show mgammaZ 0 * (-mgammaZ 0) = 1 by decide)
  simpa [mgamma, map_mul, map_neg] using h

/-! ### Integer model — parity classification of the three building blocks -/

/-- Integer model: the kinetic matrices `Kin j = γʲγ⁰` are **parity-odd**:
`P (Kin j) P⁻¹ = -Kin j`, written `P · Kin j · (-P) = -Kin j`. -/
theorem parity_KinZ (j : Fin 3) :
    mgammaZ 0 * KinZ j * (-mgammaZ 0) = -KinZ j := by
  revert j; decide

/-- Integer model: the `m₁` mass matrix `MassA = iγ⁰` is **parity-even**:
`P · MassA · (-P) = MassA`. -/
theorem parity_MassAZ : mgammaZ 0 * MassAZ * (-mgammaZ 0) = MassAZ := by decide

/-- Integer model: the `m₂` mass matrix `MassB = γ⁰γ⁵` is **parity-odd** — the
parity-breaking term: `P · MassB · (-P) = -MassB`. -/
theorem parity_MassBZ : mgammaZ 0 * MassBZ * (-mgammaZ 0) = -MassBZ := by decide

/-! ### Complex model — transport along the integer cast -/

/-- The kinetic matrices `Kin j = γʲγ⁰` are **parity-odd**: `P (Kin j) P⁻¹ = -Kin j`. -/
theorem parity_Kin (j : Fin 3) : mgamma 0 * Kin j * (-mgamma 0) = -Kin j := by
  have h := congrArg (Int.castRingHom ℂ).mapMatrix (parity_KinZ j)
  simp only [map_mul, map_neg] at h
  rw [Kin_eq_cast]; simpa [mgamma] using h

/-- The `m₁` mass matrix `MassA = iγ⁰` is **parity-even**: `P (MassA) P⁻¹ = MassA`. -/
theorem parity_MassA : mgamma 0 * MassA * (-mgamma 0) = MassA := by
  have h := congrArg (Int.castRingHom ℂ).mapMatrix parity_MassAZ
  simp only [map_mul, map_neg] at h
  rw [MassA_eq_cast]; simpa [mgamma] using h

/-- The `m₂` mass matrix `MassB = γ⁰γ⁵` is **parity-odd** — the parity-breaking term:
`P (MassB) P⁻¹ = -MassB`. -/
theorem parity_MassB : mgamma 0 * MassB * (-mgamma 0) = -MassB := by
  have h := congrArg (Int.castRingHom ℂ).mapMatrix parity_MassBZ
  simp only [map_mul, map_neg] at h
  rw [MassB_eq_cast]; simpa [mgamma] using h

/-! ### The parity transform of the full Dirac Hamiltonian -/

/-- **Parity action on the Dirac mass Hamiltonian.** Under a parity (spatial-reflection)
transformation — the momentum flip `k⃗ ↦ -k⃗` together with spinor conjugation by
`P = iγ⁰` — the Dirac Hamiltonian is mapped to the same Hamiltonian with `m₂ ↦ -m₂`:

  `P · D(-k, m₁, m₂) · P⁻¹ = D(k, m₁, -m₂)`.

The kinetic term and the `iγ⁰ m₁` mass are parity-even, while the `γ⁰γ⁵ m₂` mass is
parity-odd — the parity-breaking term the book identifies. -/
theorem parity_diracHamOp (k : Fin 3 → ℝ) (m1 m2 : ℝ) :
    mgamma 0 * diracHamOp (fun j => -(k j)) m1 m2 * (-mgamma 0)
      = diracHamOp k m1 (-m2) := by
  have hkin : mgamma 0 * (∑ j : Fin 3, ((-(k j) : ℝ) : ℂ) • Kin j) * (-mgamma 0)
      = ∑ j : Fin 3, ((k j : ℝ) : ℂ) • Kin j := by
    rw [Matrix.mul_sum, Finset.sum_mul]
    apply Finset.sum_congr rfl
    intro j _
    rw [Matrix.mul_smul, Matrix.smul_mul, parity_Kin]
    push_cast; module
  unfold diracHamOp
  simp only [Matrix.add_mul, Matrix.mul_add, Matrix.mul_smul, Matrix.smul_mul]
  rw [hkin, parity_MassA, parity_MassB]
  push_cast
  module

/-- **Parity invariance in the absence of the `m₂` term.** With `m₂ = 0` the Dirac
Hamiltonian is exactly invariant under parity: `P · D(-k, m₁, 0) · P⁻¹ = D(k, m₁, 0)`.
Thus a nonzero `m₂` (the `γ⁰γ⁵` mass) is the *sole* source of parity (CP) violation. -/
theorem parity_diracHamOp_invariant (k : Fin 3 → ℝ) (m1 : ℝ) :
    mgamma 0 * diracHamOp (fun j => -(k j)) m1 0 * (-mgamma 0)
      = diracHamOp k m1 0 := by
  have h := parity_diracHamOp k m1 0
  simpa using h

end BookProof.ChapterCPTParity
