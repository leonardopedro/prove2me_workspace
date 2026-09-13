-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.galerkin_gap_tendsto
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_galerkin_minmaxLevel_tendsto
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) :
    Tendsto (fun m : ℕ => minmaxLevelIn T (galerkinSpan b m) 1
        - minmaxLevelIn T (galerkinSpan b m) 0) atTop
      (nhds (minmaxLevel T 1 - minmaxLevel T 0)) := ((galerkin_minmaxLevel_tendsto T b 1).sub (galerkin_minmaxLevel_tendsto T b 0))
