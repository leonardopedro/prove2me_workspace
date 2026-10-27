-- Generated from ChapterQgMultiHalfDensity.lean — solution of BookProof.QgMultiHalfDensity.mpUnitary_boundedEnergyCore_surjective
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Theorems.Thm_BookProof_QgMultiHalfDensity_mpUnitary_symm_apply
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
    (hinv' : ∀ᵐ y ∂nu, Phi (Psi y) = y)
    (h : boundedEnergyCore mu (fun t => g (Phi t))) :
    ∃ x : boundedEnergyCore nu g,
      mpUnitary hPhi hPsi hinv (x : Lp ℂ 2 nu) = (h : Lp ℂ 2 mu) := by

  obtain ⟨n, hn⟩ := h.2
  have hmem : (mpUnitary hPhi hPsi hinv).symm (h : Lp ℂ 2 mu) ∈ boundedEnergyCore nu g := by
    refine ⟨n, ?_⟩
    filter_upwards [mpUnitary_symm_apply hPhi hPsi hinv (h : Lp ℂ 2 mu),
      hPsi.quasiMeasurePreserving.ae hn, hinv'] with y hy hpy hyy hbig
    rw [hy]
    exact hpy (by rwa [hyy])
  exact ⟨⟨_, hmem⟩, (mpUnitary hPhi hPsi hinv).apply_symm_apply _⟩
