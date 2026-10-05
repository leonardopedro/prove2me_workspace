-- Generated from ChapterSirkSingleTimeShift.lean — theorem BookProof.SirkSingleTime.starobinsky_qgManifold_singleTime_shiftInvert_convergence
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHashimotoComplexShifts
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.EsaClosure
open BookProof.FockSecondQuantization
open `BookProof.HashimotoShiftInvert`.
open BookProof.SirkSingleTime

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}
variable {Fin' : Type*} [NormedAddCommGroup Fin'] [InnerProductSpace ℂ Fin'] [CompleteSpace Fin']
variable {ι : Type*}


open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section


theorem BookProof.SirkSingleTime.starobinsky_qgManifold_singleTime_shiftInvert_convergence (M alpha : ℝ)
    (halpha : 0 < alpha) (Sp : VielbeinSpectrum ι) (g : ℝ) :
    ∃ (T : UnboundedSelfAdjoint (Sec ι)) (Sn : ℕ → UnboundedSelfAdjoint (Sec ι)),
      IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha) (Sp.modes g)) T.op ∧
        (∀ n, IsSelfAdjointExtension (secHam (starobinskyWall M alpha halpha)
          (truncModes (Sp.modes g) (Sp.energyWindow n))) (Sn n).op) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (Sn n).op (((l : ℝ) : ℂ) * Complex.I) (-((Sn n).resCLM l))) ∧
            ∀ u : Sec ι,
              Tendsto (fun n => -((Sn n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Sec ι) (t : ℝ),
          Tendsto (fun n => (Sn n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by sorry
