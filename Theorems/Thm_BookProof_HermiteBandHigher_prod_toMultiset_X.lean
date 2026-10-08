-- Generated from ChapterHermiteBandCalculusHigher.lean — theorem BookProof.HermiteBandHigher.prod_toMultiset_X
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculusHigher
open BookProof.HermiteBandHigher



noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.YangMillsHermite
open BookProof.NavierStokesFlow.DifferentialL2

variable {d : ℕ}


theorem BookProof.HermiteBandHigher.prod_toMultiset_X (s : Fin d →₀ ℕ) :
    ((s.toMultiset.map (fun i => (X i : MvPolynomial (Fin d) ℂ))).prod)
      = s.prod fun i k => (X i : MvPolynomial (Fin d) ℂ) ^ k := by sorry
