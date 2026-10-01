-- Generated from ChapterNavierStokesFockContinuum.lean — theorem BookProof.NavierStokesFlow.FockContinuum.sectorHamiltonian_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]

nergy (w : ℝ → ℝ) (n : ℕ) : (Fin n → ℝ) → ℝ :=
  fun ξ => ∑ k : Fin n, w (ξ k)

theorem BookProof.NavierStokesFlow.FockContinuum.sectorHamiltonian_hasZeroDeficiencyOn {w : ℝ → ℝ} (hw : Measurable w) (n : ℕ) :
    Measurable (sectorEnergy w n) :=
  Finset.univ.measurable_sum fun k _ => hw.comp (measurable_pi_apply k)

/-- **The second-quantized Hamiltonian is essentially self-adjoint on each parcel
sector of the continuum Fock space.**  On the `n`-parcel sector `L²(ℝⁿ)` the
operator `∫_ℝ w(ξ) a†(ξ) a(ξ) dξ` is multiplication by the total energy
`∑ₖ w(ξₖ)`, an operator with (in general) purely continuous spectrum and no
eigenvectors; it has vanishing adjoint deficiency on the bounded-energ := by sorry
