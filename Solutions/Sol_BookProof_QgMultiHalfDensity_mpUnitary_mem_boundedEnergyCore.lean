-- Generated from ChapterQgMultiHalfDensity.lean — solution of BookProof.QgMultiHalfDensity.mpUnitary_mem_boundedEnergyCore
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Theorems.Thm_BookProof_QgMultiHalfDensity_mpUnitary_apply
open BookProof.QgMultiHalfDensity




open MeasureTheory Set
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity

noncomputable section

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
  {mu : Measure X} {nu : Measure Y} {Phi : X → Y} {Psi : Y → X}
variable {g : Y → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hPhi : MeasurePreserving Phi mu nu)
    (hPsi : MeasurePreserving Psi nu mu) (hinv : ∀ᵐ x ∂mu, Psi (Phi x) = x)
    (x : boundedEnergyCore nu g) :
    mpUnitary hPhi hPsi hinv (x : Lp ℂ 2 nu) ∈ boundedEnergyCore mu (fun t => g (Phi t)) := by

  obtain ⟨n, hn⟩ := x.2
  refine ⟨n, ?_⟩
  filter_upwards [mpUnitary_apply hPhi hPsi hinv (x : Lp ℂ 2 nu),
    hPhi.quasiMeasurePreserving.ae hn] with t ht hpt hbig
  rw [ht]
  exact hpt hbig
