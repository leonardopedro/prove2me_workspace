-- Generated from ChapterQgMultiHalfDensity.lean — theorem BookProof.QgMultiHalfDensity.mpUnitary_symm_apply
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

theorem BookProof.QgMultiHalfDensity.mpUnitary_symm_apply (hPhi : MeasurePreserving Phi mu nu)
    (hPsi : MeasurePreserving Psi nu mu) (hinv : ∀ᵐ x ∂mu, Psi (Phi x) = x) (h : Lp ℂ 2 mu) :
    ((mpUnitary hPhi hPsi hinv).symm h : Y → ℂ) =ᵐ[nu] fun y => (h : X → ℂ) (Psi y) := by sorry
