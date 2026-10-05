-- Generated from ChapterQgMultiHalfDensity.lean — solution of BookProof.QgMultiHalfDensity.mpUnitary_apply
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
open BookProof.QgMultiHalfDensity




open MeasureTheory Set
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity

noncomputable section

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
  {mu : Measure X} {nu : Measure Y} {Phi : X → Y} {Psi : Y → X}

set_option maxHeartbeats 1000000 in
theorem solution (hPhi : MeasurePreserving Phi mu nu)
    (hPsi : MeasurePreserving Psi nu mu) (hinv : ∀ᵐ x ∂mu, Psi (Phi x) = x) (g : Lp ℂ 2 nu) :
    (mpUnitary hPhi hPsi hinv g : X → ℂ) =ᵐ[mu] fun x => (g : Y → ℂ) (Phi x) := mpIsom_apply hPhi g
