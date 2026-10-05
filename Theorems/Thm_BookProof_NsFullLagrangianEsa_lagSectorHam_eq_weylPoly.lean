-- Generated from ChapterNsFullLagrangianFockEsa.lean — theorem BookProof.NsFullLagrangianEsa.lagSectorHam_eq_weylPoly
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterNsFullLagrangianFockEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.NsFullLagrangianEsa



open MvPolynomial
open BookProof.NsFullLagrangian BookProof.YangMillsNonAbelianEsa BookProof.YangMillsHermite
open BookProof.YangMillsFriedrichs BookProof.HermiteProductCore BookProof.DirectSumEsa
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.EsaClosure

noncomputable section

theorem BookProof.NsFullLagrangianEsa.lagSectorHam_eq_weylPoly (lam lam' mu gg : ℝ) (n : ℕ) :
    lagSectorHam lam lam' mu gg n = weylPoly (lagIdx n) (lagForms lam lam' mu gg n) := by sorry
