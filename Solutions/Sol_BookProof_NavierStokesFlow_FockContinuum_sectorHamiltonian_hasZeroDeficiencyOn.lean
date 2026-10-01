-- Generated from ChapterNavierStokesFockContinuum.lean — solution of BookProof.NavierStokesFlow.FockContinuum.sectorHamiltonian_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_multOp_hasZeroDeficiencyOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum



open MeasureTheory



open FullEsa

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
nergy (w : ℝ → ℝ) (n : ℕ) : (Fin n → ℝ) → ℝ :=
  fun ξ => ∑ k : Fin n, w (ξ k)

theorem solution {w : ℝ → ℝ} (hw : Measurable w) (n : ℕ) :
    Measurable (sectorEnergy w n) :=
  Finset.univ.measurable_sum fun k _ => hw.comp (measurable_pi_apply k)

/-- **The second-quantized Hamiltonian is essentially self-adjoint on each parcel
sector of the continuum Fock space.**  On the `n`-parcel sector `L²(ℝⁿ)` the
operator `∫_ℝ w(ξ) a†(ξ) a(ξ) dξ` is multiplication by the total energy
`∑ₖ w(ξₖ)`, an operator with (in general) purely continuous spectrum and no
eigenvectors; it has vanishing adjoint deficiency on the bounded-energ :=
  y core. -/
  theorem sectorHamiltonia
