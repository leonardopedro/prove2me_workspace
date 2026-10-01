-- Generated from ChapterYangMillsGhostSector.lean — theorem BookProof.YangMillsGhost.fibreHam_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterYangMillsGhostSector
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.YangMillsGhost

variable {K : ℕ}



noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsHermite BookProof.YangMillsAbelianEsa
open BookProof.ChapterStoneResolvent


set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make the defeq checks here expensive
theorem BookProof.YangMillsGhost.fibreHam_symmetricOn (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (ω : Fin K → ℝ)
    (S : GConf K) : SymmetricOn (polyGaussCore (d := 99)) (fibreHam fabc ω S) := by sorry
