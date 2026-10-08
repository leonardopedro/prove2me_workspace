-- Generated from ChapterHermiteBandCalculusHigher.lean — theorem BookProof.HermiteBandHigher.isBandDeg_mulOp_multiset
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterYangMillsHermite
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.ChapterF7
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteBandHigher



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}


theorem BookProof.HermiteBandHigher.isBandDeg_mulOp_multiset (s : Multiset (Fin d)) :
    IsBandDeg (Multiset.card s)
      (mulOp ((s.map (fun i => (X i : MvPolynomial (Fin d) ℂ))).prod)) := by sorry
