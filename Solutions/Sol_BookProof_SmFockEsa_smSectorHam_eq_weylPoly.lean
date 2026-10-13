-- Generated from ChapterSmFockEsa.lean — solution of BookProof.SmFockEsa.smSectorHam_eq_weylPoly
import Mathlib
import Definitions.Def_ChapterSmFockEsa
import Definitions.Def_ChapterSmOneParticle
import Definitions.Def_ChapterSmOuterFock
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
open BookProof.SmFockEsa




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmOuterFock
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.TensorCore BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (n : ℕ) :
    smSectorHam P n = weylPoly (smSecMomIdx n) (smSecFieldPoly P n) := rfl
