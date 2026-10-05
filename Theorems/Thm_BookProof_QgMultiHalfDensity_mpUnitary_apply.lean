-- Generated from ChapterQgMultiHalfDensity.lean — theorem BookProof.QgMultiHalfDensity.mpUnitary_apply
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterQuantumGravityHalfDensity
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
open BookProof.QgMultiHalfDensity

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
  {mu : Measure X} {nu : Measure Y} {Phi : X → Y} {Psi : Y → X}



open MeasureTheory Set
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity

noncomputable section

theorem BookProof.QgMultiHalfDensity.mpUnitary_apply (hPhi : MeasurePreserving Phi mu nu)
    (hPsi : MeasurePreserving Psi nu mu) (hinv : ∀ᵐ x ∂mu, Psi (Phi x) = x) (g : Lp ℂ 2 nu) :
    (mpUnitary hPhi hPsi hinv g : X → ℂ) =ᵐ[mu] fun x => (g : Y → ℂ) (Phi x) := by sorry
