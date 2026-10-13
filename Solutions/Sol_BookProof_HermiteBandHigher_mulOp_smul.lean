-- Generated from ChapterHermiteBandCalculusHigher.lean — solution of BookProof.YangMillsHermite.mulOp_smul
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterF7
open BookProof.HermiteBandHigher




noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (f : MvPolynomial (Fin d) ℂ) : BookProof.YangMillsHermite.mulOp (c • f) = c • BookProof.YangMillsHermite.mulOp f := by

  refine LinearMap.ext fun p => ?_
  simp [BookProof.YangMillsHermite.mulOp]
