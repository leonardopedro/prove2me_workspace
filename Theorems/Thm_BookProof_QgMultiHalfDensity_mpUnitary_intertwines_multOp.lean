-- Generated from ChapterQgMultiHalfDensity.lean — theorem BookProof.QgMultiHalfDensity.mpUnitary_intertwines_multOp
import Definitions.Def_ChapterQuantumGravityHalfDensity
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterNavierStokesFockContinuum
open BookProof.ChapterLinftyMultiplication
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QgMultiHalfDensity



open MeasureTheory Set
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity

noncomputable section

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
  {mu : Measure X} {nu : Measure Y} {Phi : X → Y} {Psi : Y → X}
variable {g : Y → ℝ}

theorem BookProof.QgMultiHalfDensity.mpUnitary_intertwines_multOp (hPhi : MeasurePreserving Phi mu nu)
    (hPsi : MeasurePreserving Psi nu mu) (hinv : ∀ᵐ x ∂mu, Psi (Phi x) = x)
    (hg : Measurable g) (x : boundedEnergyCore nu g) :
    ((multOp mu (hg.comp hPhi.measurable)
        ⟨mpUnitary hPhi hPsi hinv (x : Lp ℂ 2 nu),
          mpUnitary_mem_boundedEnergyCore hPhi hPsi hinv x⟩ :
        boundedEnergyCore mu (fun t => g (Phi t))) : Lp ℂ 2 mu)
      = mpUnitary hPhi hPsi hinv ((multOp nu hg x : boundedEnergyCore nu g) : Lp ℂ 2 nu) := by sorry
