-- Generated from ChapterQgMultiHalfDensity.lean — solution of BookProof.QgMultiHalfDensity.mpUnitary_symm_eq
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
    (hPsi : MeasurePreserving Psi nu mu) (hinv : ∀ᵐ x ∂mu, Psi (Phi x) = x) (h : Lp ℂ 2 mu) :
    (mpUnitary hPhi hPsi hinv).symm h = mpIsom hPsi h := by

  refine (mpUnitary hPhi hPsi hinv).injective ?_
  rw [LinearIsometryEquiv.apply_symm_apply]
  exact (mpIsom_mpIsom hPhi hPsi hinv h).symm
