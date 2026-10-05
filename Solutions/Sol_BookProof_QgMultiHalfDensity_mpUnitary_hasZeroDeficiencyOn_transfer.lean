-- Generated from ChapterQgMultiHalfDensity.lean — solution of BookProof.QgMultiHalfDensity.mpUnitary_hasZeroDeficiencyOn_transfer
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Theorems.Thm_BookProof_QgMultiHalfDensity_mpUnitary_mem_boundedEnergyCore
import Theorems.Thm_BookProof_QgMultiHalfDensity_mpUnitary_boundedEnergyCore_surjective
import Theorems.Thm_BookProof_QgMultiHalfDensity_mpUnitary_intertwines_multOp
import Theorems.Thm_BookProof_QuantumGravityDensitized_densitized_hasZeroDeficiencyOn_transfer
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
    (hinv' : ∀ᵐ y ∂nu, Phi (Psi y) = y) (hg : Measurable g)
    (hflat : BookProof.NavierStokesFlow.HasZeroDeficiencyOn
      (boundedEnergyCore mu (fun t => g (Phi t))) (multOp mu (hg.comp hPhi.measurable))) :
    BookProof.NavierStokesFlow.HasZeroDeficiencyOn
      (boundedEnergyCore nu g) (multOp nu hg) :=
  BookProof.QuantumGravityDensitized.densitized_hasZeroDeficiencyOn_transfer
      (mpUnitary hPhi hPsi hinv)
      (mpUnitary_mem_boundedEnergyCore hPhi hPsi hinv)
      (mpUnitary_boundedEnergyCore_surjective hPhi hPsi hinv hinv')
      (mpUnitary_intertwines_multOp hPhi hPsi hinv hg) hflat
