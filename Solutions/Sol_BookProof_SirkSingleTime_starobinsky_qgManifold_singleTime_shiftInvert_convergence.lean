-- Generated from ChapterSirkSingleTimeShift.lean — solution of BookProof.SirkSingleTime.starobinsky_qgManifold_singleTime_shiftInvert_convergence
import Mathlib
import Definitions.Def_ChapterSirkSingleTimeShift
import Theorems.Thm_BookProof_SirkSingleTime_qgOuterFock_singleTime_shiftInvert_convergence
import Theorems.Thm_BookProof_QgManifoldModeInstance_VielbeinSpectrum_energyWindow_exhausts
open BookProof.SirkSingleTime



open scoped InnerProductSpace


open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.HashimotoShiftInvert

noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
variable {T : UnboundedSelfAdjoint E} {S : ℕ → UnboundedSelfAdjoint E}
variable {Fin' : Type*} [NormedAddCommGroup Fin'] [InnerProductSpace ℂ Fin'] [CompleteSpace Fin']
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ)
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
          Tendsto (fun n => (Sn n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  qgOuterFock_singleTime_shiftInvert_convergence (starobinskyWall M alpha halpha)
      (Sp.modes g) Sp.energyWindow Sp.energyWindow_exhausts
