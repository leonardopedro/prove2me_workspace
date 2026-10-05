-- Generated from ChapterFockCubicUnbounded.lean — theorem BookProof.FockCubicUnbounded.cubeA_coord
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockCubicUnbounded


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

theorem BookProof.FockCubicUnbounded.cubeA_coord (k : ℕ) (x : FockAlg) (γ : Conf) :
    cubeA k x γ
      = ((Real.sqrt (γ k) : ℝ) : ℂ) * ((Real.sqrt ((dn k γ) k) : ℝ) : ℂ)
          * ((Real.sqrt ((dn k (dn k γ)) k) : ℝ) : ℂ) * x (dn k (dn k (dn k γ)))
        + ((Real.sqrt ((γ k : ℝ) + 1) : ℝ) : ℂ)
            * ((Real.sqrt (((up k γ) k : ℝ) + 1) : ℝ) : ℂ)
            * ((Real.sqrt (((up k (up k γ)) k : ℝ) + 1) : ℝ) : ℂ)
            * x (up k (up k (up k γ))) := by sorry
